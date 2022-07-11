#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

TALOS_VERSION=v1.2.0-alpha.0
TALOS_ARCH=amd64

# util function to retry a command until it succeeds
retry() {
  local COUNT=1
  local DELAY=0
  local RESULT=0
  while [[ "${COUNT}" -le 10 ]]; do
    [[ "${RESULT}" -ne 0 ]] && {
      [ "$(which tput 2> /dev/null)" != "" ] && [ -n "$TERM" ] && tput setaf 1
      echo -e "\n${*} failed... retrying ${COUNT} of 10.\n" >&2
      [ "$(which tput 2> /dev/null)" != "" ] && [ -n "$TERM" ] && tput sgr0
    }
    "${@}" && { RESULT=0 && break; } || RESULT="${?}"
    COUNT="$((COUNT + 1))"

    # Increase the delay with each iteration.
    DELAY="$((DELAY + 10))"
    sleep $DELAY
  done

  [[ "${COUNT}" -gt 10 ]] && {
    [ "$(which tput 2> /dev/null)" != "" ] && [ -n "$TERM" ] && tput setaf 1
    echo -e "\nThe command failed 10 times.\n" >&2
    [ "$(which tput 2> /dev/null)" != "" ] && [ -n "$TERM" ] && tput sgr0
  }

  return "${RESULT}"
}

# download Talos ISO
wget --timestamping https://github.com/siderolabs/talos/releases/download/${TALOS_VERSION}/talos-${TALOS_ARCH}.iso

# define and configure vagrant mgmt network
virsh net-define --file mgmt-network.xml
virsh net-autostart talos-vagrant-libvirt-mgmt
virsh net-start talos-vagrant-libvirt-mgmt || true

# bring up the VMs using vagrant
vagrant up --provider=libvirt

sudo chown -R "$USER:$USER" logs/

# create & bootstrap initial control plane node
talosctl -n 192.168.42.101 apply-config --insecure --file controlplane.yaml
retry talosctl --talosconfig ./talosconfig -n 192.168.42.101 bootstrap

# get kubeconfig from the initial control plane node
retry talosctl --talosconfig ./talosconfig -n 192.168.42.101 kubeconfig ./kubeconfig

# join remaining control plane nodes
talosctl -n 192.168.42.102 apply-config --insecure --file controlplane.yaml
talosctl -n 192.168.42.103 apply-config --insecure --file controlplane.yaml

# join worker nodes
talosctl -n 192.168.42.104 apply-config --insecure --file worker.yaml
talosctl -n 192.168.42.105 apply-config --insecure --file worker.yaml
