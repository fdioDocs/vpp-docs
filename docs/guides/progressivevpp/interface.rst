.. _interface:

.. toctree::

Interface
=========

VPP command learned in this exercise
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#. `create host-interface <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_devices_af_packet.html#clicmd_create_host-interface>`_
#. `set int state <https://docs.fd.io/vpp/17.04/clicmd_src_vnet.html#clicmd_set_interface_state>`_
#. `set int ip address <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_ip.html#clicmd_set_interface_ip_address>`_
#. `show hardware <https://docs.fd.io/vpp/17.04/clicmd_src_vnet.html#clicmd_show_hardware-interfaces>`_
#. `show int <https://docs.fd.io/vpp/17.04/clicmd_src_vnet.html#clicmd_show_interfaces>`_
#. `show int addr <https://docs.fd.io/vpp/17.04/clicmd_src_vnet.html#clicmd_show_interfaces>`_
#. `trace add <https://docs.fd.io/vpp/17.04/clicmd_src_vlib.html#clicmd_trace_add>`_
#. `clear trace <https://docs.fd.io/vpp/17.04/clicmd_src_vlib.html#clicmd_clear_trace>`_
#. `ping <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_ip.html#clicmd_ping>`_
#. `show ip arp <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_ethernet.html#clicmd_show_ip_arp>`_
#. `show ip fib <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_fib.html#clicmd_show_ip_fib>`_

Topology
~~~~~~~~

.. figure:: /_images/Create_Interface_Topology.jpg
  :alt: Figure: Create Interface Topology

  Figure: Create Interface Topology

Initial State
~~~~~~~~~~~~~

The initial state here is presumed to be the final state from the
exercise `VPP Basics <VPP/Progressive_VPP_Tutorial#Exercise:_vpp_basics>`__
 
Action: Create veth interfaces on host
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Linux, there is a type of interface call 'veth'. Think of a 'veth'
interface as being an interface that has two ends to it (rather than
one).

Create a veth interface with one end named **vpp1out** and the other
named **vpp1host**

::

   sudo ip link add name vpp1out type veth peer name vpp1host

Turn up both ends:

::

   sudo ip link set dev vpp1out up
   sudo ip link set dev vpp1host up

Assign an IP address

::

   sudo ip addr add 10.10.1.1/24 dev vpp1host

Display the result:

::

   sudo ip addr show vpp1host

Example Output:

::

   10: vpp1host@vpp1out: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
       link/ether 5e:97:e3:41:aa:b8 brd ff:ff:ff:ff:ff:ff
       inet 10.10.1.1/24 scope global vpp1host
          valid_lft forever preferred_lft forever
       inet6 fe80::5c97:e3ff:fe41:aab8/64 scope link 
          valid_lft forever preferred_lft forever

Action: Create vpp host- interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a host interface attached to **vpp1out**.

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock create host-interface name vpp1out

Output:

::

   host-vpp1out

Confirm the interface:

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock show hardware

Example Output:

::

                 Name                Idx   Link  Hardware
   host-vpp1out                       1     up   host-vpp1out
     Ethernet address 02:fe:48:ec:d5:a7
     Linux PACKET socket interface
   local0                             0    down  local0
     local

Turn up the interface:

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock set int state host-vpp1out up

Confirm the interface is up:

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock show int

::

                 Name               Idx       State          Counter          Count     
   host-vpp1out                      1         up       
   local0                            0        down

Assign ip address 10.10.1.2/24

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock set int ip address host-vpp1out 10.10.1.2/24

Confirm the ip address is assigned:

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock show int addr

::

   host-vpp1out (up):
     10.10.1.2/24
   local0 (dn):
