.. _installingPrereq:

.. toctree::

Overview
^^^^^^^^

This section will describe how to install a Virtual Machine (VM) for Vagrant, and install containers inside that VM.

Containers are environments similar to VM's, but are known to be faster since they do not simulate  separate kernels and hardware, as VM's do. You can read more about `Linux containers here <https://linuxcontainers.org/>`_.


In this section, we'll use Vagrant to run our VirtualBox VM. **Vagrant** automates the configuration of virtual environments by giving you the ability to create and destroy VM's quick and seemlessly.
You have the git cloned repo of VPP locally on your machine.

.. _prereqlabel:

Prerequisites
_____________

You have the `Git VPP repo <https://github.com/FDio/vpp>`_ cloned locally on your machine.

*Alternatively* to cloning the whole repo, you can manually make (copy and paste the contents) the files yourself. This guide will use the following files from that repo: *Vagrantfile, build.sh, env.sh, and update.sh*.

.. note:: IMPORTANT!

   While you *can* just blindly run every command/script, understanding how the Vagrantfile and scripts interact with each other are vital to customizing your own VM that has your specific configuration options and packages installed.


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

Here we are on a 64-bit version of CentOS, downloading and installing Vagrant 2.1.2:

.. code-block:: shell

   $ yum -y install https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_x86_64.rpm

This is a similar command, but on a 64-bit version of Debian:

.. code-block:: shell

   $ sudo apt-get install https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_x86_64.deb


If you want to download a newer version of Vagrant or one specific to your OS and architecture, go to the Vagrant `download page <https://www.vagrantup.com/downloads.html>`_, right-click and copy the link address for your specified version, and replace the above install command for the OS of your current system.

Vagrantfiles
____________

The *Vagrantfile* contains the configuration settings for the machine and software requirements of your VM. The syntax of Vagrantfiles is *Ruby*, but experience with Ruby is not completely necessary.

The Vagrantfile creates a **Vagrant Box**, which is a "development-ready box" that can be copied to other machines to recreate the same environment. The `Vagrant website for boxes <https://app.vagrantup.com/boxes/search>`_  shows you (for your specific OS and VM software), how to configure a Vagrantfile.


Setting your ENV(Environment) Variables
_______________________________________

The :ref:`prereqlabel` sets some of the VM configuration options based on your ENV variables.

This is the **env.sh** script found in **vpp/extras/vagrant** that sets ENV variables using the **export**command.

.. code-block:: bash

   export VPP_VAGRANT_DISTRO="ubuntu1604"
   export VPP_VAGRANT_NICS=2
   export VPP_VAGRANT_VMCPU=4
   export VPP_VAGRANT_VMRAM=4096 

By reading the code for the :ref:`vppVagrantfile`, you can see these same ENV variables used for setting the VM's distro (default is ubuntu16.04), amount of NICs (default is 3 - 1 x NAT - host access and 2 x VPP DPDK enabled), CPUs (default is 2), and RAM (default is 4096).

Adding your own ENV variable is easy. For example, if you wanted to setup proxies for your VM, you would add the lines containing the **export** commands found in :ref:`buildingcommands`. 

Of course you don't need a script to do all of this, you could just enter these commands one by one, however having them in a script is nice if you want to provision m



Creating your VM
________________

Looking at the :ref:`vppVagrantfile`, we can see that the default OS is Ubuntu 16.04:

.. code-block:: ruby

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

As mentioned above, if you want a box configured to a different OS, you can specify which `OS box you want on the Vagrant boxes page <https://app.vagrantup.com/boxes/search>`_.

Once you have the **Vagrantfile**, as specified in the :ref:`prereqlabel` section, all you need to do is:

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

  To poweroff your VM, type:

  .. code-block:: shell

     $ vagrant halt <id>

  To resume your VM, type:

  .. code-block:: shell

     $ vagrant resume <id>
     
  To destroy your VM, type:

  .. code-block:: shell

     $ vagrant destroy <id>

  For other commands, visit the `Vagrant CLI Page <https://www.vagrantup.com/docs/cli/>`_.






