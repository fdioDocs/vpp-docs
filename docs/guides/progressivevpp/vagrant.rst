.. _vagrant:

.. toctree::

Exercise: Routing
-----------------

Skills to be Learned
^^^^^^^^^^^^^^^^^^^^

In this exercise you will learn these new skills:

#. Add route to Linux Host routing table
#. Add route to FD.io VPP routing table

And revisit the old ones:

#. Examine FD.io VPP routing table
#. Enable trace on vpp1 and vpp2
#. ping from host to FD.io VPP
#. Examine and clear trace on vpp1 and vpp2
#. ping from FD.io VPP to host
#. Examine and clear trace on vpp1 and vpp2

FD.io VPP command learned in this exercise
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. `ip route
   add <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_ip.html#clicmd_ip_route>`__

Topology
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. figure:: /_images/Connecting_two_vpp_instances_with_memif.png
   :alt: Connect two FD.io VPP topology

   Connect two FD.io VPP topology

Initial State
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The initial state here is presumed to be the final state from the
exercise `Connecting two FD.io VPP
instances <VPP/Progressive_VPP_Tutorial#Connecting_two_vpp_instances>`__

Action: Setup host route
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: console

   sudo ip route add 10.10.2.0/24 via 10.10.1.2
   ip route

.. code-block:: console

   default via 10.0.2.2 dev enp0s3 
   10.0.2.0/24 dev enp0s3  proto kernel  scope link  src 10.0.2.15 
   10.10.1.0/24 dev vpp1host  proto kernel  scope link  src 10.10.1.1 
   10.10.2.0/24 via 10.10.1.2 dev vpp1host 

Setup return route on vpp2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: console

   sudo vppctl -s /run/vpp/cli-vpp2.sock ip route add 10.10.1.0/24  via 10.10.2.1

Ping from host through vpp1 to vpp2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Setup a trace on vpp1 and vpp2
#. Ping 10.10.2.2 from the host
#. Examine the trace on vpp1 and vpp2
#. Clear the trace on vpp1 and vpp2

Exercise: Switching
-------------------

Skills to be Learned
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Associate an interface with a bridge domain
#. Create a loopback interaface
#. Create a BVI (Bridge Virtual Interface) for a bridge domain
#. Examine a bridge domain

FD.io VPP command learned in this exercise
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. `show
   bridge <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_l2.html#clicmd_show_bridge-domain>`__
#. `show bridge
   detail <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_l2.html#clicmd_show_bridge-domain>`__
#. `set int l2
   bridge <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_l2.html#clicmd_set_interface_l2_bridge>`__
#. `show l2fib
   verbose <https://docs.fd.io/vpp/17.04/clicmd_src_vnet_l2.html#clicmd_show_l2fib>`__

Topology
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. figure:: /_images/Switching_Topology.jpg
   :alt: Switching Topology

   Switching Topology

Initial state
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Unlike previous exercises, for this one you want to start tabula rasa.

Note: You will lose all your existing config in your FD.io VPP instances!

To clear existing config from previous exercises run:

::

   ps -ef | grep vpp | awk '{print $2}'| xargs sudo kill
   sudo ip link del dev vpp1host
   sudo ip link del dev vpp1vpp2

Action: Run FD.io VPP instances
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Run a vpp instance named **vpp1**
#. Run a vpp instance named **vpp2**

Action: Connect vpp1 to host
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Create a veth with one end named vpp1host and the other named
   vpp1out.
#. Connect vpp1out to vpp1
#. Add ip address 10.10.1.1/24 on vpp1host

Action: Connect vpp1 to vpp2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Create a veth with one end named vpp1vpp2 and the other named
   vpp2vpp1.
#. Connect vpp1vpp2 to vpp1.
#. Connect vpp2vpp1 to vpp2.

Action: Configure Bridge Domain on vpp1
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Check to see what bridge domains already exist, and select the first
bridge domain number not in use:

.. code-block:: console

   sudo vppctl -s /run/vpp/cli-vpp1.sock show bridge-domain

.. code-block:: console

     ID   Index   Learning   U-Forwrd   UU-Flood   Flooding   ARP-Term     BVI-Intf   
     0      0        off        off        off        off        off        local0    

In the example above, there is bridge domain ID '0' already. Even though
sometimes we might get feedback as below:

.. code-block:: console

   no bridge-domains in use

the bridge domain ID '0' still exists, where no operations are
supported. For instance, if we try to add host-vpp1out and host-vpp1vpp2
to bridge domain ID 0, we will get nothing setup.

.. code-block:: console

   sudo vppctl -s /run/vpp/cli-vpp1.sock set int l2 bridge host-vpp1out 0
   sudo vppctl -s /run/vpp/cli-vpp1.sock set int l2 bridge host-vpp1vpp2 0
   sudo vppctl -s /run/vpp/cli-vpp1.sock show bridge-domain 0 detail

.. code-block:: console

   show bridge-domain: No operations on the default bridge domain are supported

So we will create bridge domain 1 instead of playing with the default
bridge domain ID 0.

Add host-vpp1out to bridge domain ID 1

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock set int l2 bridge host-vpp1out 1

Add host-vpp1vpp2 to bridge domain ID1

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock set int l2 bridge host-vpp1vpp2  1

Examine bridge domain 1:

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock show bridge-domain 1 detail

::

     BD-ID   Index   BSN  Age(min)  Learning  U-Forwrd  UU-Flood  Flooding  ARP-Term  BVI-Intf
       1       1      0     off        on        on        on        on       off       N/A

              Interface           If-idx ISN  SHG  BVI  TxFlood        VLAN-Tag-Rewrite
            host-vpp1out            1     1    0    -      *                 none
            host-vpp1vpp2           2     1    0    -      *                 none

Action: Configure loopback interface on vpp2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   sudo vppctl -s /run/vpp/cli-vpp2.sock create loopback interface

::

   loop0

Add the ip address 10.10.1.2/24 to vpp2 interface loop0. Set the state
of interface loop0 on vpp2 to 'up'

Action: Configure bridge domain on vpp2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Check to see the first available bridge domain ID (it will be 1 in this
case)

Add interface loop0 as a bridge virtual interface (bvi) to bridge domain
1

::

   sudo vppctl -s /run/vpp/cli-vpp2.sock set int l2 bridge loop0 1 bvi

Add interface vpp2vpp1 to bridge domain 1

::

   sudo vppctl -s /run/vpp/cli-vpp2.sock set int l2 bridge host-vpp2vpp1  1

Examine the bridge domain and interfaces.

Action: Ping from host to vpp and vpp to host
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Add trace on vpp1 and vpp2
#. ping from host to 10.10.1.2
#. Examine and clear trace on vpp1 and vpp2
#. ping from vpp2 to 10.10.1.1
#. Examine and clear trace on vpp1 and vpp2

Action: Examine l2 fib
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock show l2fib verbose

::

       Mac Address     BD Idx           Interface           Index  static  filter  bvi   Mac Age (min) 
    de:ad:00:00:00:00    1            host-vpp1vpp2           2       0       0     0      disabled    
    c2:f6:88:31:7b:8e    1            host-vpp1out            1       0       0     0      disabled    
   2 l2fib entries

::

   sudo vppctl -s /run/vpp/cli-vpp2.sock show l2fib verbose

::

       Mac Address     BD Idx           Interface           Index  static  filter  bvi   Mac Age (min) 
    de:ad:00:00:00:00    1                loop0               2       1       0     1      disabled    
    c2:f6:88:31:7b:8e    1            host-vpp2vpp1           1       0       0     0      disabled    
   2 l2fib entries

Source NAT
----------

Skills to be Learned
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Abusing networks namespaces for fun and profit
#. Configuring snat address
#. Configuring snat inside and outside interfaces

vpp command learned in this exercise
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. `snat add interface
   address <https://docs.fd.io/vpp/17.04/clicmd_src_plugins_snat.html#clicmd_snat_add_interface_address>`__
#. `set interface
   snat <https://docs.fd.io/vpp/17.04/clicmd_src_plugins_snat.html#clicmd_set_interface_snat>`__

Topology
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. figure:: /_images/SNAT_Topology.jpg
   :alt: SNAT Topology

   SNAT Topology

Initial state
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Unlike previous exercises, for this one you want to start tabula rasa.

Note: You will lose all your existing config in your vpp instances!

To clear existing config from previous exercises run:

::

   ps -ef | grep vpp | awk '{print $2}'| xargs sudo kill
   sudo ip link del dev vpp1host
   sudo ip link del dev vpp1vpp2

Action: Install vpp-plugins
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Snat is supported by a plugin, so vpp-plugins need to be installed

::

   sudo apt-get install vpp-plugins

Action: Create vpp instance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create one vpp instance named vpp1.

Confirm snat plugin is present:

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock show plugins

::

    Plugin path is: /usr/lib/vpp_plugins
    Plugins loaded: 
     1.ioam_plugin.so
     2.ila_plugin.so
     3.acl_plugin.so
     4.flowperpkt_plugin.so
     5.snat_plugin.so
     6.libsixrd_plugin.so
     7.lb_plugin.so

Action: Create veth interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Create a veth interface with one end named vpp1outside and the other
   named vpp1outsidehost
#. Assign IP address 10.10.1.1/24 to vpp1outsidehost
#. Create a veth interface with one end named vpp1inside and the other
   named vpp1insidehost
#. Assign IP address 10.10.2.1/24 to vpp1outsidehost

Because we'd like to be able to route \*via\* our vpp instance to an
interface on the same host, we are going to put vpp1insidehost into a
network namespace

Create a new network namespace 'inside'

::

   sudo ip netns add inside

Move interface vpp1inside into the 'inside' namespace:

::

   sudo ip link set dev vpp1insidehost up netns inside

Assign an ip address to vpp1insidehost

::

   sudo ip netns exec inside ip addr add 10.10.2.1/24 dev vpp1insidehost

Create a route inside the netns:

::

   sudo ip netns exec inside ip route add 10.10.1.0/24 via 10.10.2.2

Action: Configure vpp outside interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Create a vpp host interface connected to vpp1outside
#. Assign ip address 10.10.1.2/24
#. Create a vpp host interface connected to vpp1inside
#. Assign ip address 10.10.2.2/24

Action: Configure snat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Configure snat to use the address of host-vpp1outside

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock snat add interface address host-vpp1outside

Configure snat inside and outside interfaces

::

   sudo vppctl -s /run/vpp/cli-vpp1.sock set interface snat in host-vpp1inside out host-vpp1outside

Action: Prepare to Observe Snat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Observing snat in this configuration is interesting. To do so, vagrant
ssh a second time into your VM and run:

::

   sudo tcpdump -s 0 -i vpp1outsidehost

Also enable tracing on vpp1

Action: Ping via snat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   sudo ip netns exec inside ping -c 1 10.10.1.1

Action: Confirm snat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Examine the tcpdump output and vpp1 trace to confirm snat occurred.

