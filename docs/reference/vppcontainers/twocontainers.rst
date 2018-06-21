.. _twocontainers:

.. toctree::


=====================================
VPP with two Containers using Vagrant
=====================================


Overview
________

This section will cover how to install a VM (Virtual Machine) for Vagrant, and how to use containers inside that VM.

Containers are environments similar to VM's, but are known to be faster since they do not simulate  seperate kernels and hardware, as VM's do. You can read more about `Linux containers here <https://linuxcontainers.org/>`_.


In this section, we'll use Vagrant to run our VirtualBox VM. **Vagrant** automates the configuration of virtual environments by giving you the ability to create and destroy VM's quick and seemlessly.

Installing VirtualBox
_____________________

First, download VirtualBox, which is virtualization software for creating VM's.

If you're on CentOS, follow the `steps here <https://wiki.centos.org/HowTos/Virtualization/VirtualBox#head-81de410879b8e7f18a127f638160e036ab99684e>`_.


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


Starting up
^^^^^^^^^^^

Begin by changing directories to where you want to install your box/VM.

In this guide, we will choose a box operating on the Official Ubuntu Server 14.04 LTS build, found on the `Vagrant Boxes page <https://app.vagrantup.com/boxes/search>`_.

Making a Vagrantfile using this initial box is easy:  

.. code-block:: shell

   $ vagrant init ubuntu/trusty64


This will create a *Vagrantfile* in your current directory, which you can further configure based on the requirements you want your VM to have. To learn more about configuration options, visit the `Vagrant Vagrantfile page <https://www.vagrantup.com/docs/vagrantfile/>`_.

Alternatively, if you want to start with an empty Vagrantfile, you can create an empty text file that has this configuration option:

.. code-block:: console

   Vagrant.configure("2") do |config|
     config.vm.box = "ubuntu/trusty64"
   end

























