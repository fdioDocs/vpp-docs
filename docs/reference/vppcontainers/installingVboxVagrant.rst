.. _installingVboxVagrant:

.. toctree::

Installation and setup
======================

Installing VirtualBox
_____________________

First download VirtualBox, which is virtualization software for creating VM's.

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


If you want to download a newer version of Vagrant or one specific to your OS and architecture, go to the Vagrant `download page <https://www.vagrantup.com/downloads.html>`_, right-click and copy the link address for your specified version, and replace the above install command for your respective OS and architechure.

Vagrantfiles
____________

A *Vagrantfile* contains the box configuration settings for your VM. The syntax of Vagrantfiles is Ruby (Ruby experience is not necessary).

The command **vagrant up** creates a *Vagrant Box* based on your Vagrantfile. A Vagrant box is one of the motivations for using Vagrant - its a "development-ready box" that can be copied to other machines to recreate the same environment. 

It's common for people to think that a Vagrant box *is* the VM. But rather, the VM is *inside* a Vagrant box, with the box containing additional configuration options you can set, such as VM options, scripts to run on boot, etc.

This `Vagrant website for boxes <https://app.vagrantup.com/boxes/search>`_  shows you how to configure a basic Vagrantfile for your specific OS and VM software.