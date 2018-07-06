.. _installingPrereq:

.. toctree::

Overview
^^^^^^^^

This section will describe how to install a Virtual Machine (VM) for Vagrant, and install containers inside that VM.

Containers are environments similar to VM's, but are known to be faster since they do not simulate  seperate kernels and hardware, as VM's do. You can read more about `Linux containers here <https://linuxcontainers.org/>`_.


In this section, we'll use Vagrant to run our VirtualBox VM. **Vagrant** automates the configuration of virtual environments by giving you the ability to create and destroy VM's quick and seemlessly.
You have the git cloned repo of VPP locally on your machine.

Prerequisites
_____________

You have the git cloned repo of VPP locally on your machine.


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






