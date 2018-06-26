.. _twocontainers:

.. toctree::

=====================================
VPP with two Containers using Vagrant
=====================================

Prerequistes
^^^^^^^^^^^^^^
You have the VPP git cloned repo locally on your machine.

Overview
________

This section will cover how to install a VM (Virtual Machine) for Vagrant, and how to use containers inside that VM.

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

    If you don't have 64-bit CentOS, or want to download a newer version of Vagrant (if 2.1.1 is not the latest), go to the Vagrant `download page <https://www.vagrantup.com/downloads.html>`_, copy the download link for your specified version (a **.rpm** file), and replace the https:// link in the above *yum* command with the link you copied.


Vagrantfiles
____________

Preface
^^^^^^^

The *Vagrantfile* contains the configuration settings for the machine and software requirements of your VM. Thus, any user with your *Vagrantfile* can instantiate a VM with those exact settings.

The syntax of Vagrantfiles is the programming language *Ruby*, but experience with Ruby is not completely necessary as most modifications to your  Vagrantfile is changing variable values. 

The Vagrantfile creates a **Vagrant Box**, which is a "development-ready box" that can be copied to other machines to recreate the same environment. The `Vagrant website for boxes <https://app.vagrantup.com/boxes/search>`_  shows you all the available Vagrant Boxes containing different operating systems.


Going into your VM
^^^^^^^^^^^^^^^^^^

As a prereq, you should already have the Git VPP directory on your machine.

Change directories to your **vpp/extras/vagrant** directory.

Since there is a *Vagrantfile* already there for you, all you need to do is:

.. code-block:: shell

  $ vagrant up

Note that doing this above command may take quite some time, since you are installing a VM. Take a break and get some scooby snacks.

To confirm it is up, we can do: 

.. code-block:: shell

  $ vagrant global-status

You will have only one machine running, but I have multiple to ssh into.

.. code-block:: console

  [centos@dskl09 vpp-userdemo]$ vagrant global-status
  id       name    provider   state    directory                                           
  -----------------------------------------------------------------------------------------
  d90a17b  default virtualbox poweroff /home/centos/andrew-vpp/vppsb/vpp-userdemo          
  77b085e  default virtualbox poweroff /home/centos/andrew-vpp/vppsb2/vpp-userdemo         
  c1c8952  default virtualbox poweroff /home/centos/andrew-vpp/testingVPPSB/extras/vagrant 
  c199140  default virtualbox running  /home/centos/andrew-vpp/vppsb3/vpp-userdemo 


Getting inside your VM
^^^^^^^^^^^^^^^^^^^^^^


Lets ssh into our newly created box:

.. code-block:: shell

    vagrant ssh <id>

Now you're in your VM.

.. code-block:: console

  [[centos@dskl09 vpp-userdemo]$ vagrant ssh c1c
  Welcome to Ubuntu 16.04 LTS (GNU/Linux 4.4.0-21-generic x86_64)

   * Documentation:  https://help.ubuntu.com/
  Last login: Mon Jun 25 08:05:38 2018 from 10.0.2.2
  vagrant@localhost:~$ ls



Let's set up the hugepages:

.. code-block:: shell
  
  $ sysctl -w vm.nr_hugepages=1024


.. code-block:: console 
  
  sysctl: permission denied on key 'vm.nr_hugepages'

Oh no! What happened? We're not root. Lets change to root.

.. code-block:: shell

  $ sudo bash

Then we can perform the previous sysctl command with no issues.

To check if it was set correctly:

.. code-block:: shell

  $ HUGEPAGES=`sysctl -n  vm.nr_hugepages`
  $ echo $HUGEPAGES
  1024

Which should output 1024. 

Now we want to add the VPP repo as to our sources list in our VM. We append the FD.io binary repo to a file called 99fd.io.list, so *apt-get* update and install can use it:

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

Making our containers
^^^^^^^^^^^^^^^^^^^^^


We want to configure an LXC (Linux container) network to create an inteface for Linux bridge and a unconsumed second inteface for our containers.

LXC configuration is split in two parts. Container configuration and system configuration.

The system configuration is located at /etc/lxc/lxc.conf or ~/.config/lxc/lxc.conf for unprivileged containers.

This configuration file is used to set values such as default lookup paths and storage backend settings for LXC.

Both containers will have these veth0 and veth_link1 network names and types.

This can be found in the **/sys/class/net** directory (We'll see this directory in use down below).


.. code-block:: shell

    echo -e "lxc.network.name = veth0\nlxc.network.type = veth\nlxc.network.name = veth_link1"  | sudo tee -a /etc/lxc/default.conf


This next command will create an Ubuntu Xenial container named "cone".

.. code-block:: shell

      $ sudo lxc-create -t download -n cone -- --dist ubuntu --release xenial --arch amd64 --keyserver hkp://p80.pool.sks-keyservers.net:80


If sucessful, you'll get an output similar to this:

.. code-block:: console
    
    You just created an Ubuntu xenial amd64 (20180625_07:42) container.

    To enable SSH, run: apt install openssh-server
    No default root or user password are set by LXC.


You can make another container "ctwo".

.. code-block:: shell

     $ sudo lxc-create -t download -n ctwo -- --dist ubuntu --release xenial --arch amd64 --keyserver hkp://p80.pool.sks-keyservers.net:80


You can list your containers:


.. code-block:: shell

     $ sudo lxc-ls

.. code-block:: console

    cone ctwo


Here are useful `lxc container commands <https://help.ubuntu.com/lts/serverguide/lxc.html.en-GB#lxc-basic-usage>`_.


.. code-block:: shell

      sudo lxc-ls --fancy
      sudo lxc-start --name u1 --daemon
      sudo lxc-info --name u1
      sudo lxc-stop --name u1
      sudo lxc-destroy --name u1


Start the first container:

.. code-block:: shell
    
    $ sudo lxc-start --name cone

Verify its running:

.. code-block:: shell
    
    $ sudo lxc-ls --fancy

.. code-block:: console

    NAME STATE   AUTOSTART GROUPS IPV4 IPV6 
    cone RUNNING 0         -      -    -    
    ctwo STOPPED 0         -      -    -  


Lets go into container cone and install prerequisites such as VPP:

.. code-block:: shell
    
    $ sudo lxc-attach -n cone


Creating Containers
^^^^^^^^^^^^^^^^^^^
Creating contai









