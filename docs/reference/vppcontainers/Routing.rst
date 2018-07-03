.. _Routing:

.. toctree::

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







