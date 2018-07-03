.. _twocontainers:

.. toctree::

=====================================
VPP with two Containers using Vagrant
=====================================

Prerequistes
^^^^^^^^^^^^
You have the git cloned repo of VPP locally on your machine.

Overview
________

This section will describe how to install a Virtual Machine (VM) for Vagrant, and install containers inside that VM.

Containers are environments similar to VM's, but are known to be faster since they do not simulate  seperate kernels and hardware, as VM's do. You can read more about `Linux containers here <https://linuxcontainers.org/>`_.


In this section, we'll use Vagrant to run our VirtualBox VM. **Vagrant** automates the configuration of virtual environments by giving you the ability to create and destroy VM's quick and seemlessly.

Installing VirtualBox
_____________________

First, download VirtualBox, which is virtualization software for creating VM's.

If you're on CentOS, follow the `steps here <https://wiki.centos.org/HowTos/Virtualization/VirtualBox>`_.


If you're on Ubuntu, perform:

.. code-block:: shell

   $ sudo apt-get install virtualbox 

Installing Vagrant
__________________


Now its time to install Vagrant.

Here we are on a 64-bit version of CentOS, downloading and installing Vagrant 2.1.1:

.. code-block:: shell

   $ yum -y install https://releases.hashicorp.com/vagrant/2.1.1/vagrant_2.1.1_x86_64.rpm


.. note::

    This is an installation of Vagrant 2.1.1 on a 64-bit CentOS machine.

    If you don't have 64-bit CentOS or want to download a newer version of Vagrant, go to the Vagrant `download page <https://www.vagrantup.com/downloads.html>`_, copy the download link for your specified version, and replace the https:// link above and use the install command for the OS of your current system (*yum install* for CentOS or *apt-get install* for Ubuntu).


Vagrantfiles
____________

Preface
^^^^^^^

The *Vagrantfile* contains the configuration settings for the machine and software requirements of your VM. Thus, any user with your *Vagrantfile* can instantiate a VM with those exact settings.

The syntax of Vagrantfiles is the programming language *Ruby*, but experience with Ruby is not completely necessary as most modifications to your  Vagrantfile is changing variable values. 

The Vagrantfile creates a **Vagrant Box**, which is a "development-ready box" that can be copied to other machines to recreate the same environment. The `Vagrant website for boxes <https://app.vagrantup.com/boxes/search>`_  shows you all the available Vagrant Boxes containing different operating systems.


Creating your VM
^^^^^^^^^^^^^^^^

As a prerequiste, you should already have the Git VPP directory on your machine.

Change directories to your *vpp/extras/vagrant* directory.

Looking at the **Vagrantfile**, we can see that the default OS is Ubuntu 16.04:

.. code-block:: console

    # -*- mode: ruby -*-
    # vi: set ft=ruby :

    Vagrant.configure(2) do |config|

      # Pick the right distro and bootstrap, default is ubuntu1604
      distro = ( ENV['VPP_VAGRANT_DISTRO'] || "ubuntu1604")
      if distro == 'centos7'
        config.vm.box = "centos/7"
        config.vm.box_version = "1708.01"
        config.ssh.insert_key = false
      elsif distro == 'opensuse'
        config.vm.box = "opensuse/openSUSE-42.3-x86_64"
        config.vm.box_version = "1.0.4.20170726"
      else
        config.vm.box = "puppetlabs/ubuntu-16.04-64-nocm"

As mentioned in the preface above, if you want a box configured to a different OS, you can specify which `OS box you want on the Vagrant boxes page <https://app.vagrantup.com/boxes/search>`_.

Since there already exists a *Vagrantfile* from our repo, all you need to do is:

.. code-block:: shell

  $ vagrant up

Note that doing this above command may take quite some time, since you are installing a VM. Take a break and get some scooby snacks.

To confirm it is up, we can do: 

.. code-block:: shell

  $ vagrant global-status

You will have only one machine running, but I have multiple as shown below:

.. code-block:: console

  [centos@dskl09 vpp-userdemo]$ vagrant global-status
  id       name    provider   state    directory                                           
  -----------------------------------------------------------------------------------------
  d90a17b  default virtualbox poweroff /home/centos/andrew-vpp/vppsb/vpp-userdemo          
  77b085e  default virtualbox poweroff /home/centos/andrew-vpp/vppsb2/vpp-userdemo         
  c1c8952  default virtualbox poweroff /home/centos/andrew-vpp/testingVPPSB/extras/vagrant 
  c199140  default virtualbox running  /home/centos/andrew-vpp/vppsb3/vpp-userdemo 


.. note::
  To poweroff your VM, type **vagrant halt <id>**.
  If you want to try other commands on your box, visit the `Vagrant CLI Page <https://www.vagrantup.com/docs/cli/>`_.



Accessing your VM
^^^^^^^^^^^^^^^^^


Lets ssh into our newly created box:

.. code-block:: shell

    $ vagrant ssh <id>

Now you're in your VM.

.. code-block:: console

  [[centos@dskl09 vpp-userdemo]$ vagrant ssh c1c
  Welcome to Ubuntu 16.04 LTS (GNU/Linux 4.4.0-21-generic x86_64)

   * Documentation:  https://help.ubuntu.com/
  Last login: Mon Jun 25 08:05:38 2018 from 10.0.2.2
  vagrant@localhost:~$


.. note::
  
  Type **exit** if you want to exit your VM, or container (which we'll get to soon.)


Let's set up the hugepages:

.. code-block:: shell
  
  $ sysctl -w vm.nr_hugepages=1024


.. code-block:: console 
  
  vagrant@localhost:~ sysctl: permission denied on key 'vm.nr_hugepages'

Oh no! What happened? We're not root. Lets change to root.

.. code-block:: shell

  $ sudo bash

Then we can perform the previous sysctl command with no issues.

To check if it was set correctly:

.. code-block:: shell

  $ HUGEPAGES=`sysctl -n  vm.nr_hugepages`
  $ echo $HUGEPAGES

Which should output 1024. 

Now we want to add the VPP repo as to our sources list in our VM. We append the FD.io binary repo to a file called 99fd.io.list, so *apt-get* *update* and *install* can use it:

.. code-block:: shell

    ls /etc/apt # here is where you can see your sources.list.d directory after doing this command below

    echo "deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io.ubuntu.xenial.main/ ./" | sudo tee -a /etc/apt/sources.list.d/99fd.io.list

  

Do an *apt-get* to make sure the VM and its libraries are updated:

.. code-block:: shell
  
  $ apt-get update

Now we want to install VPP and lxc (for our containers):

.. code-block:: shell

  $ apt-get install vpp vpp-lib vpp-dpdk-dkms bridge-utils lxc
  

Now we can start running VPP on our host VM:


.. code-block:: shell
  
  $ service vpp start 


Check if we installed lxc:

.. code-block:: shell
  
   $ lxc-checkconfig

Creating Containers
___________________


The system configuration is located at /etc/lxc/lxc.conf or ~/.config/lxc/lxc.conf for unprivileged containers.

This configuration file is used to set values such as default lookup paths and storage backend settings for LXC. It can be found in each container's **/sys/class/net** directory.

The command below configures the LXC (Linux container) networks to create an interface for a Linux bridge and an unconsumed second interface to be used by each container.

For more information on linux containers with Ubuntu, visit the `lxc server guide <https://help.ubuntu.com/lts/serverguide/lxc.html>`_.

.. code-block:: shell

    echo -e "lxc.network.name = veth0\nlxc.network.type = veth\nlxc.network.name = veth_link1"  | sudo tee -a /etc/lxc/default.conf


This next command will create an Ubuntu Xenial container named "cone".

.. code-block:: shell

      $ sudo lxc-create -t download -n cone -- --dist ubuntu --release xenial --arch amd64 --keyserver hkp://p80.pool.sks-keyservers.net:80


If successful, you'll get an output similar to this:

.. code-block:: console
    
    root@localhost:~# You just created an Ubuntu xenial amd64 (20180625_07:42) container.

    To enable SSH, run: apt install openssh-server
    No default root or user password are set by LXC.


You can make another container "ctwo".

.. code-block:: shell

     $ sudo lxc-create -t download -n ctwo -- --dist ubuntu --release xenial --arch amd64 --keyserver hkp://p80.pool.sks-keyservers.net:80


Afterwards, you can list your containers:


.. code-block:: shell

     $ sudo lxc-ls

.. code-block:: console

    root@localhost:~# cone ctwo


Here are some `lxc container commands <https://help.ubuntu.com/lts/serverguide/lxc.html.en-GB#lxc-basic-usage>`_ you may find useful:


.. code-block:: shell

      sudo lxc-ls --fancy
      sudo lxc-start --name u1 --daemon
      sudo lxc-info --name u1
      sudo lxc-stop --name u1
      sudo lxc-destroy --name u1


Lets start the first container:

.. code-block:: shell
    
    $ sudo lxc-start --name cone

Verify its running:

.. code-block:: shell
    
    $ sudo lxc-ls --fancy

.. code-block:: console

    NAME STATE   AUTOSTART GROUPS IPV4 IPV6 
    cone RUNNING 0         -      -    -    
    ctwo STOPPED 0         -      -    -  


Container prerequisites
_______________________

Lets go into container *cone* and install prerequisites such as VPP, as well as some additional commands:

To enter our container via the shell, type:

.. code-block:: shell
    
    $ sudo lxc-attach -n cone

Which should output:

.. code-block:: console
    
    root@cone:/#

Now run the linux DHCP setup and install VPP: 

.. code-block:: shell
    
    $ sudo bash
    $ resolvconf -d eth0
    $ dhclient
    $ apt-get install -y wget
    $ echo "deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io.ubuntu.xenial.main/ ./" | sudo tee -a /etc/apt/sources.list.d/99fd.io.list
    $ apt-get update
    $ apt-get install -y --force-yes vpp
    $ sh -c 'echo  \"\\ndpdk {\\n   no-pci\\n}\" >> /etc/vpp/startup.conf'

And lets start VPP in this container as well:

.. code-block:: shell
    
    $ service vpp start

Now repeat this process for the second container, ctwo, and also don't forget to "start" it with **sudo lxc-start --name ctwo**.



Routing two Containers
______________________

Now lets go through the process of connecting these two linux containers to VPP and pinging between them.

In container cone, lets check our current network configuration:

.. code-block:: shell
    
    $ ip -o a

We can see that we have three network interfaces, *lo, veth0*, and *veth_link1*.

.. code-block:: console
    
    root@cone:/# ip -o a
    1: lo    inet 127.0.0.1/8 scope host lo\       valid_lft forever preferred_lft forever
    1: lo    inet6 ::1/128 scope host \       valid_lft forever preferred_lft forever
    30: veth0    inet 10.0.3.157/24 brd 10.0.3.255 scope global veth0\       valid_lft forever preferred_lft forever
    30: veth0    inet6 fe80::216:3eff:fee2:d0ba/64 scope link \       valid_lft forever preferred_lft forever
    32: veth_link1    inet6 fe80::2c9d:83ff:fe33:37e/64 scope link \       valid_lft forever preferred_lft forever

Notice that *veth_link1* has no assigned IP.

We can also check if our interfaces are down or up:

.. code-block:: shell
    
    $ ip link

.. code-block:: console
    
    root@cone:/# ip link
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    30: veth0@if31: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
        link/ether 00:16:3e:e2:d0:ba brd ff:ff:ff:ff:ff:ff link-netnsid 0
    32: veth_link1@if33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
        link/ether 2e:9d:83:33:03:7e brd ff:ff:ff:ff:ff:ff link-netnsid 0

.. note::

    Take note that **our** network index for veth_link1 is 32, and that its parent index is 33, shown by veth_link1@if33. Yours will probably be different, but take note of these index's.

Lets make sure your loopback interface is up, and lets assign an IP and gateway to veth_link1.

.. code-block:: shell
    
    $ ip link set dev lo up
    $ ip addr add 172.16.1.2/24 dev veth_link1
    $ ip link set dev veth_link1 up
    $ ip route add default via 172.16.1.1 dev veth_link1

Here, the IP is 172.16.1.2/24 and the gateway is 172.16.1.1.

When I try to add the gateway, I get an error:

.. code-block:: console
    
    root@cone:/# ip route add default via 172.16.1.1 dev veth_link1
    RTNETLINK answers: File exists

Fix this by renewing the DHCP leases, and then trying again:

.. code-block:: shell
    
    root@cone:/# dhclient -r
    Killed old client process
    root@cone:/# ip route add default via 172.16.1.1 dev veth_link1
    root@cone:/#

Now it works! :)

We can run some commands to verify our setup:

.. code-block:: shell
    
    root@cone:/# ip -o a
    1: lo    inet 127.0.0.1/8 scope host lo\       valid_lft forever preferred_lft forever
    1: lo    inet6 ::1/128 scope host \       valid_lft forever preferred_lft forever
    30: veth0    inet6 fe80::216:3eff:fee2:d0ba/64 scope link \       valid_lft forever preferred_lft forever
    32: veth_link1    inet 172.16.1.2/24 scope global veth_link1\       valid_lft forever preferred_lft forever
    32: veth_link1    inet6 fe80::2c9d:83ff:fe33:37e/64 scope link \       valid_lft forever preferred_lft forever
    root@cone:/# route
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
    default         172.16.1.1      0.0.0.0         UG    0      0        0 veth_link1
    172.16.1.0      *               255.255.255.0   U     0      0        0 veth_link1


We see that the IP has been assigned, as well as our default gateway.

Now exit this container and repeat this setup with **ctwo**, except with IP 172.16.2.2/24 and gateway 172.16.2.1.


After thats done, if you're still in a container, go back into your VM:

.. code-block:: shell
    
    $ exit

Now, in the VM, if we run **ip link** we can see the host *veth* network interfaces, and their connection with the container *veth's*.

.. code-block:: shell
    
    vagrant@localhost:~$ ip link
    1: lo: <LOOPBACK> mtu 65536 qdisc noqueue state DOWN mode DEFAULT group default qlen 1
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
        link/ether 08:00:27:33:82:8a brd ff:ff:ff:ff:ff:ff
    3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
        link/ether 08:00:27:d9:9f:ac brd ff:ff:ff:ff:ff:ff
    4: enp0s9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
        link/ether 08:00:27:78:84:9d brd ff:ff:ff:ff:ff:ff
    5: lxcbr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
        link/ether 00:16:3e:00:00:00 brd ff:ff:ff:ff:ff:ff
    19: veth0C2FL7@if18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master lxcbr0 state UP mode DEFAULT group default qlen 1000
        link/ether fe:0d:da:90:c1:65 brd ff:ff:ff:ff:ff:ff link-netnsid 1
    21: veth8NA72P@if20: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
        link/ether fe:1c:9e:01:9f:82 brd ff:ff:ff:ff:ff:ff link-netnsid 1
    31: vethXQMY4C@if30: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master lxcbr0 state UP mode DEFAULT group default qlen 1000
        link/ether fe:9a:d9:29:40:bb brd ff:ff:ff:ff:ff:ff link-netnsid 0
    33: vethQL7KOC@if32: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
        link/ether fe:ed:89:54:47:a2 brd ff:ff:ff:ff:ff:ff link-netnsid 0

Remember our network interface index 32 in *cone*? We can see at the bottom the name of the 33rd index **vethQL7KOC@if32**. Take note of this network interface name for the veth connected to cone, and the other network interface name for ctwo.

With VPP in our VM, we can show our current VPP interfaces:

.. code-block:: shell
    
    $ sudo vppctl show inter

Which should only show local0.

Based on these names, which are specific to my systems, we can setup the VPP host-interfaces:

.. code-block:: shell
    
    $ sudo vppctl create host-interface name vethQL7K0C
    $ sudo vppctl create host-interface name veth8NA72P

Verify they have been setup:

.. code-block:: shell
    
    $ sudo vppctl show inter

Which should output **three** interfaces, lo, and the other two network interfaces we just set up.


Change the links state to up:

.. code-block:: shell
    
    $ sudo vppctl set interface state host-vethQL7K0C up
    $ sudo vppctl set interface state host-veth8NA72P up


Add IP addresses for the other end of each veth link:

.. code-block:: shell
    
    $ sudo vppctl set interface ip address host-vethQL7K0C 172.16.1.1/24
    $ sudo vppctl set interface ip address host-veth8NA72P 172.16.2.1/24


Verify the interfaces are up with the previous show inter command, or you can also see the L3 table, or FIB by doing:

.. code-block:: shell
    
    $ sudo vppctl show ip fib

At long last you probably want to see some pings:

.. code-block:: shell
    
    $ sudo lxc-attach -n cone -- ping -c3 172.16.2.2
    $ sudo lxc-attach -n ctwo -- ping -c3 172.16.1.2


Which should send/recieve three packets for each command.







