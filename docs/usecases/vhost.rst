.. _vhost:

.. toctree::

FD.io VPP with Virtual Machines
===============================

This chapter will describe how to use FD.io VPP with virtual machines. We describe
how to create Vhost port with VPP and how to connect them to VPP. We will also discuss
the limitations of Vhost.

Prerequisites
-------------

For this use we will assume FD.io VPP is installed. We will also assume you can create and start
a virtual image. In this case we will use an ubuntu cloud image and manage it using virsh. All the
FD.io VPP commands are being run from a sudo. 

Topology 
---------

In this case we will use 2 bare metal systems. On one system we will be running linux,
the other will be running FD.io VPP.

.. figure:: /_images/vhost-topo.png
   :alt:

   Vhost Use Case Topology

Create Virtual Interfaces
-------------------------

We will start on the system running FD.io VPP and show that no Virtual interfaces have been created. We do this
using the :ref:`showintcommand` command.

Notice we do not have any virtual interfaces. We do have an interface (TenGigabitEthernet86/0/0) that is up and connected 
to a system running, in our example standard linux. We will use this system to verify our connectivity to our VM with ping.

.. code-block:: console

    $ sudo bash
    # vppctl
        _______    _        _   _____  ___
     __/ __/ _ \  (_)__    | | / / _ \/ _ \
     _/ _// // / / / _ \   | |/ / ___/ ___/
     /_/ /____(_)_/\___/   |___/_/  /_/
    
    vpp# clear interfaces
    vpp# show int
                  Name               Idx       State          Counter          Count
    TenGigabitEthernet86/0/0          1         up
    TenGigabitEthernet86/0/1          2        down
    local0                            0        down
    vpp#

For more information on the interface commands refer to: :ref:`intcommands`

