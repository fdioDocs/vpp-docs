.. _progressivevpp:

.. toctree::

########################
Progressive VPP Tutorial
########################

Overview 
========

Learn to run FD.io VPP on a single Ubuntu 16.04 VM using Vagrant with this walkthrough
covering basic FD.io VPP senarios. Useful FD.io VPP commands will be used, and
will discuss basic operations, and the state of a running FD.io VPP on a system.

.. note::

    This is *not* intended to be a 'How to Run in a Production Environment' set of instructions.

.. _introduction-to-vpp-vagrant:

Setting up your environment
---------------------------

All of these exercises are designed to be performed on an Ubuntu 16.04 (Xenial) box.

* If you have an Ubuntu 16.04 box on which you have sudo or root access, you can feel free to use that.
* If you do not, a Vagrantfile is provided to setup a basic Ubuntu 16.04 box for you. 

.. toctree::

    settingupenvironment.rst

The DPDK Plugin will be disabled for this section. The link below demonstrates how this is done. 

.. toctree::

    removedpdkplugin.rst

Running Vagrant
---------------

VPP runs in userspace.  In a production environment you will often run it with DPDK to connect to real NICs or vhost to connect to VMs.
In those circumstances you usually run a single instance of FD.io VPP.

For purposes of this tutorial, it is going to be extremely useful to run multiple instances of vpp, and connect them to each other to form
a topology.  Fortunately, FD.io VPP supports this.

When running multiple FD.io VPP instances, each instance needs to have specified a 'name' or 'prefix'.  In the example below, the 'name' or 'prefix' is "vpp1". Note that only one instance can use the dpdk plugin, since this plugin is trying to acquire a lock on a file.

.. toctree::

    vagrant.rst

Start a FD.io VPP shell using vppctl
------------------------------------

The command *$ sudo vppctl* will launch a FD.io VPP shell with which you can run multiple FD.io VPP commands interactively by running:

.. code-block:: console
    
    $ sudo vppctl 
       _______    _        _   _____  ___
    __/ __/ _ \  (_)__    | | / / _ \/ _ \
    _/ _// // / / / _ \   | |/ / ___/ ___/
    /_/ /____(_)_/\___/   |___/_/  /_/
    vpp# show ver
    vpp v18.07-release built by root on c469eba2a593 at Mon Jul 30 23:27:03 UTC 2018

Create an Interface
-------------------

Skills to be Learned
^^^^^^^^^^^^^^^^^^^^

#. Create a veth interface in Linux host
#. Assign an IP address to one end of the veth interface in the Linux host
#. Create a vpp host-interface that connected to one end of a veth interface via AF_PACKET
#. Add an ip address to a vpp interface
#. Setup a 'trace'
#. View a 'trace'
#. Clear a 'trace'
#. Verify using ping from host
#. Ping from vpp
#. Examine Arp Table
#. Examine ip fib

.. toctree::

    interface.rst

Traces
------

.. toctree::

    traces.rst