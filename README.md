# Talos Linux on Vagrant & Libvirt

This repository aims to provide an example of bringing up a 
[Talos Linux](https://www.talos.dev/) cluster using 
[Vagrant](https://www.vagrantup.com/) with [libvirt](https://libvirt.org/) provider.

# Prerequisites

- Linux with KVM and libvirt
- Vagrant
- [vagrant-libvirt plugin](https://github.com/vagrant-libvirt/vagrant-libvirt)
- Enough resources to be able to create 5 VMs with 2 CPUs, 2G of RAM and 16G of virtual disk each
- `192.168.42.0/24` subnet being free for the VMs
- [kubectl](https://kubernetes.io/docs/reference/kubectl/) and [talosctl](https://www.talos.dev/latest/learn-more/talosctl/)

# How-to

To create a Talos cluster:
```bash
$ ./up.sh
```

You can interact with the cluster using the `talosconfig` and `kubeconfig` in the project root:
```bash
$ talosctl --talosconfig talosconfig -n 192.168.42.101 get members
NODE             NAMESPACE   TYPE     ID                     VERSION   HOSTNAME               MACHINE TYPE   OS                       ADDRESSES
192.168.42.101   cluster     Member   talos-192-168-42-101   15        talos-192-168-42-101   controlplane   Talos (v1.2.0-alpha.0)   ["192.168.42.42","192.168.42.101"]
...
192.168.42.101   cluster     Member   talos-192-168-42-105   1         talos-192-168-42-105   controlplane   Talos (v1.2.0-alpha.0)   ["192.168.42.105"]

$ kubectl --kubeconfig kubeconfig get nodes -owide
NAME                   STATUS   ROLES                  AGE   VERSION   INTERNAL-IP      EXTERNAL-IP   OS-IMAGE                 KERNEL-VERSION   CONTAINER-RUNTIME
talos-192-168-42-101   Ready    control-plane,master   15m   v1.24.2   192.168.42.101   <none>        Talos (v1.2.0-alpha.0)   5.15.51-talos    containerd://1.6.6
...
talos-192-168-42-105   Ready    control-plane,master   15m   v1.24.2   192.168.42.105   <none>        Talos (v1.2.0-alpha.0)   5.15.51-talos    containerd://1.6.6

$ kubectl --kubeconfig kubeconfig get pod --all-namespaces
NAMESPACE     NAME                                           READY   STATUS    RESTARTS      AGE
kube-system   coredns-77c7b7d9b-sh9nw                        1/1     Running   0               3m8s
kube-system   coredns-77c7b7d9b-wp59r                        1/1     Running   0               3m8s
kube-system   kube-apiserver-talos-192-168-42-101            1/1     Running   0               118s
...
```

You can tail serial console logs under `logs/` directory
```bash
$ tail -f logs/vm-1.log
$ tail -f logs/vm-2.log
```

To destroy everything:
```bash
$ ./down.sh
```
