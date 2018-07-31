.. _traces:

.. toctree::

Add Trace
~~~~~~~~~

.. code-block:: console 

   sudo vppctl -s /run/vpp/cli-vpp1.sock trace add af-packet-input 10

Ping from Host to FD.io VPP
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console 

   ping -c 1 10.10.1.2
   PING 10.10.1.2 (10.10.1.2) 56(84) bytes of data.
   64 bytes from 10.10.1.2: icmp_seq=1 ttl=64 time=0.557 ms

   --- 10.10.1.2 ping statistics ---
   1 packets transmitted, 1 received, 0% packet loss, time 0ms
   rtt min/avg/max/mdev = 0.557/0.557/0.557/0.000 ms

Examine Trace of ping from host to FD.io VPP 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console 

   sudo vppctl -s /run/vpp/cli-vpp1.sock show trace

   ------------------- Start of thread 0 vpp_main -------------------
   Packet 1

   00:09:30:397798: af-packet-input
     af_packet: hw_if_index 1 next-index 4
       tpacket2_hdr:
         status 0x20000001 len 42 snaplen 42 mac 66 net 80
         sec 0x588fd3ac nsec 0x375abde7 vlan 0 vlan_tpid 0
   00:09:30:397906: ethernet-input
     ARP: fa:13:55:ac:d9:50 -> ff:ff:ff:ff:ff:ff
   00:09:30:397912: arp-input
     request, type ethernet/IP4, address size 6/4
     fa:13:55:ac:d9:50/10.10.1.1 -> 00:00:00:00:00:00/10.10.1.2
   00:09:30:398191: host-vpp1out-output
     host-vpp1out
     ARP: 02:fe:48:ec:d5:a7 -> fa:13:55:ac:d9:50
     reply, type ethernet/IP4, address size 6/4
     02:fe:48:ec:d5:a7/10.10.1.2 -> fa:13:55:ac:d9:50/10.10.1.1

   Packet 2

   00:09:30:398227: af-packet-input
     af_packet: hw_if_index 1 next-index 4
       tpacket2_hdr:
         status 0x20000001 len 98 snaplen 98 mac 66 net 80
         sec 0x588fd3ac nsec 0x37615060 vlan 0 vlan_tpid 0
   00:09:30:398295: ethernet-input
     IP4: fa:13:55:ac:d9:50 -> 02:fe:48:ec:d5:a7
   00:09:30:398298: ip4-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x9b46
       fragment id 0x894c, flags DONT_FRAGMENT
     ICMP echo_request checksum 0x83c
   00:09:30:398300: ip4-lookup
     fib 0 dpo-idx 5 flow hash: 0x00000000
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x9b46
       fragment id 0x894c, flags DONT_FRAGMENT
     ICMP echo_request checksum 0x83c
   00:09:30:398303: ip4-local
       ICMP: 10.10.1.1 -> 10.10.1.2
         tos 0x00, ttl 64, length 84, checksum 0x9b46
         fragment id 0x894c, flags DONT_FRAGMENT
       ICMP echo_request checksum 0x83c
   00:09:30:398305: ip4-icmp-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x9b46
       fragment id 0x894c, flags DONT_FRAGMENT
     ICMP echo_request checksum 0x83c
   00:09:30:398307: ip4-icmp-echo-request
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x9b46
       fragment id 0x894c, flags DONT_FRAGMENT
     ICMP echo_request checksum 0x83c
   00:09:30:398317: ip4-load-balance
     fib 0 dpo-idx 10 flow hash: 0x0000000e
     ICMP: 10.10.1.2 -> 10.10.1.1
       tos 0x00, ttl 64, length 84, checksum 0xbef3
       fragment id 0x659f, flags DONT_FRAGMENT
     ICMP echo_reply checksum 0x103c
   00:09:30:398318: ip4-rewrite
     tx_sw_if_index 1 dpo-idx 2 : ipv4 via 10.10.1.1 host-vpp1out: IP4: 02:fe:48:ec:d5:a7 -> fa:13:55:ac:d9:50 flow hash: 0x00000000
     IP4: 02:fe:48:ec:d5:a7 -> fa:13:55:ac:d9:50
     ICMP: 10.10.1.2 -> 10.10.1.1
       tos 0x00, ttl 64, length 84, checksum 0xbef3
       fragment id 0x659f, flags DONT_FRAGMENT
     ICMP echo_reply checksum 0x103c
   00:09:30:398320: host-vpp1out-output
     host-vpp1out
     IP4: 02:fe:48:ec:d5:a7 -> fa:13:55:ac:d9:50
     ICMP: 10.10.1.2 -> 10.10.1.1
       tos 0x00, ttl 64, length 84, checksum 0xbef3
       fragment id 0x659f, flags DONT_FRAGMENT
     ICMP echo_reply checksum 0x103c

Clear trace buffer
~~~~~~~~~~~~~~~~~~

.. code-block:: console 

   sudo vppctl -s /run/vpp/cli-vpp1.sock clear  trace

Ping from FD.io VPP to Host 
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console 

   sudo vppctl -s /run/vpp/cli-vpp1.sock ping 10.10.1.1
   64 bytes from 10.10.1.1: icmp_seq=1 ttl=64 time=.0865 ms
   64 bytes from 10.10.1.1: icmp_seq=2 ttl=64 time=.0914 ms
   64 bytes from 10.10.1.1: icmp_seq=3 ttl=64 time=.0943 ms
   64 bytes from 10.10.1.1: icmp_seq=4 ttl=64 time=.0959 ms
   64 bytes from 10.10.1.1: icmp_seq=5 ttl=64 time=.0858 ms

   Statistics: 5 sent, 5 received, 0% packet loss

Action: Examine Trace of ping from vpp to host
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console 

   sudo vppctl -s /run/vpp/cli-vpp1.sock show trace

   ------------------- Start of thread 0 vpp_main -------------------
   Packet 1

   00:12:47:155326: af-packet-input
     af_packet: hw_if_index 1 next-index 4
       tpacket2_hdr:
         status 0x20000001 len 98 snaplen 98 mac 66 net 80
         sec 0x588fd471 nsec 0x161c61ad vlan 0 vlan_tpid 0
   00:12:47:155331: ethernet-input
     IP4: fa:13:55:ac:d9:50 -> 02:fe:48:ec:d5:a7
   00:12:47:155334: ip4-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x2604
       fragment id 0x3e8f
     ICMP echo_reply checksum 0x1a83
   00:12:47:155335: ip4-lookup
     fib 0 dpo-idx 5 flow hash: 0x00000000
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x2604
       fragment id 0x3e8f
     ICMP echo_reply checksum 0x1a83
   00:12:47:155336: ip4-local
       ICMP: 10.10.1.1 -> 10.10.1.2
         tos 0x00, ttl 64, length 84, checksum 0x2604
         fragment id 0x3e8f
       ICMP echo_reply checksum 0x1a83
   00:12:47:155339: ip4-icmp-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x2604
       fragment id 0x3e8f
     ICMP echo_reply checksum 0x1a83
   00:12:47:155342: ip4-icmp-echo-reply
     ICMP echo id 17572 seq 1
   00:12:47:155349: error-drop
     ip4-icmp-input: unknown type

   Packet 2

   00:12:48:155330: af-packet-input
     af_packet: hw_if_index 1 next-index 4
       tpacket2_hdr:
         status 0x20000001 len 98 snaplen 98 mac 66 net 80
         sec 0x588fd472 nsec 0x1603e95b vlan 0 vlan_tpid 0
   00:12:48:155337: ethernet-input
     IP4: fa:13:55:ac:d9:50 -> 02:fe:48:ec:d5:a7
   00:12:48:155341: ip4-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x2565
       fragment id 0x3f2e
     ICMP echo_reply checksum 0x7405
   00:12:48:155343: ip4-lookup
     fib 0 dpo-idx 5 flow hash: 0x00000000
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x2565
       fragment id 0x3f2e
     ICMP echo_reply checksum 0x7405
   00:12:48:155344: ip4-local
       ICMP: 10.10.1.1 -> 10.10.1.2
         tos 0x00, ttl 64, length 84, checksum 0x2565
         fragment id 0x3f2e
       ICMP echo_reply checksum 0x7405
   00:12:48:155346: ip4-icmp-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x2565
       fragment id 0x3f2e
     ICMP echo_reply checksum 0x7405
   00:12:48:155348: ip4-icmp-echo-reply
     ICMP echo id 17572 seq 2
   00:12:48:155351: error-drop
     ip4-icmp-input: unknown type

   Packet 3

   00:12:49:155331: af-packet-input
     af_packet: hw_if_index 1 next-index 4
       tpacket2_hdr:
         status 0x20000001 len 98 snaplen 98 mac 66 net 80
         sec 0x588fd473 nsec 0x15eb77ef vlan 0 vlan_tpid 0
   00:12:49:155337: ethernet-input
     IP4: fa:13:55:ac:d9:50 -> 02:fe:48:ec:d5:a7
   00:12:49:155341: ip4-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x249e
       fragment id 0x3ff5
     ICMP echo_reply checksum 0xf446
   00:12:49:155343: ip4-lookup
     fib 0 dpo-idx 5 flow hash: 0x00000000
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x249e
       fragment id 0x3ff5
     ICMP echo_reply checksum 0xf446
   00:12:49:155345: ip4-local
       ICMP: 10.10.1.1 -> 10.10.1.2
         tos 0x00, ttl 64, length 84, checksum 0x249e
         fragment id 0x3ff5
       ICMP echo_reply checksum 0xf446
   00:12:49:155349: ip4-icmp-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x249e
       fragment id 0x3ff5
     ICMP echo_reply checksum 0xf446
   00:12:49:155350: ip4-icmp-echo-reply
     ICMP echo id 17572 seq 3
   00:12:49:155354: error-drop
     ip4-icmp-input: unknown type

   Packet 4

   00:12:50:155335: af-packet-input
     af_packet: hw_if_index 1 next-index 4
       tpacket2_hdr:
         status 0x20000001 len 98 snaplen 98 mac 66 net 80
         sec 0x588fd474 nsec 0x15d2ffb6 vlan 0 vlan_tpid 0
   00:12:50:155341: ethernet-input
     IP4: fa:13:55:ac:d9:50 -> 02:fe:48:ec:d5:a7
   00:12:50:155346: ip4-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x2437
       fragment id 0x405c
     ICMP echo_reply checksum 0x5b6e
   00:12:50:155347: ip4-lookup
     fib 0 dpo-idx 5 flow hash: 0x00000000
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x2437
       fragment id 0x405c
     ICMP echo_reply checksum 0x5b6e
   00:12:50:155350: ip4-local
       ICMP: 10.10.1.1 -> 10.10.1.2
         tos 0x00, ttl 64, length 84, checksum 0x2437
         fragment id 0x405c
       ICMP echo_reply checksum 0x5b6e
   00:12:50:155351: ip4-icmp-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x2437
       fragment id 0x405c
     ICMP echo_reply checksum 0x5b6e
   00:12:50:155353: ip4-icmp-echo-reply
     ICMP echo id 17572 seq 4
   00:12:50:155356: error-drop
     ip4-icmp-input: unknown type

   Packet 5

   00:12:51:155324: af-packet-input
     af_packet: hw_if_index 1 next-index 4
       tpacket2_hdr:
         status 0x20000001 len 98 snaplen 98 mac 66 net 80
         sec 0x588fd475 nsec 0x15ba8726 vlan 0 vlan_tpid 0
   00:12:51:155331: ethernet-input
     IP4: fa:13:55:ac:d9:50 -> 02:fe:48:ec:d5:a7
   00:12:51:155335: ip4-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x23cc
       fragment id 0x40c7
     ICMP echo_reply checksum 0xedb3
   00:12:51:155337: ip4-lookup
     fib 0 dpo-idx 5 flow hash: 0x00000000
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x23cc
       fragment id 0x40c7
     ICMP echo_reply checksum 0xedb3
   00:12:51:155338: ip4-local
       ICMP: 10.10.1.1 -> 10.10.1.2
         tos 0x00, ttl 64, length 84, checksum 0x23cc
         fragment id 0x40c7
       ICMP echo_reply checksum 0xedb3
   00:12:51:155341: ip4-icmp-input
     ICMP: 10.10.1.1 -> 10.10.1.2
       tos 0x00, ttl 64, length 84, checksum 0x23cc
       fragment id 0x40c7
     ICMP echo_reply checksum 0xedb3
   00:12:51:155343: ip4-icmp-echo-reply
     ICMP echo id 17572 seq 5
   00:12:51:155346: error-drop
     ip4-icmp-input: unknown type

   Packet 6

   00:12:52:175185: af-packet-input
     af_packet: hw_if_index 1 next-index 4
       tpacket2_hdr:
         status 0x20000001 len 42 snaplen 42 mac 66 net 80
         sec 0x588fd476 nsec 0x16d05dd0 vlan 0 vlan_tpid 0
   00:12:52:175195: ethernet-input
     ARP: fa:13:55:ac:d9:50 -> 02:fe:48:ec:d5:a7
   00:12:52:175200: arp-input
     request, type ethernet/IP4, address size 6/4
     fa:13:55:ac:d9:50/10.10.1.1 -> 00:00:00:00:00:00/10.10.1.2
   00:12:52:175214: host-vpp1out-output
     host-vpp1out
     ARP: 02:fe:48:ec:d5:a7 -> fa:13:55:ac:d9:50
     reply, type ethernet/IP4, address size 6/4
     02:fe:48:ec:d5:a7/10.10.1.2 -> fa:13:55:ac:d9:50/10.10.1.1

After examinging the trace, clear it again.

Examine arp tables
~~~~~~~~~~~~~~~~~~

.. code-block:: console 

   sudo vppctl -s /run/vpp/cli-vpp1.sock show ip arp
       Time           IP4       Flags      Ethernet              Interface       
       570.4092    10.10.1.1      D    fa:13:55:ac:d9:50       host-vpp1out      

Examine routing table
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console 

   sudo vppctl -s /run/vpp/cli-vpp1.sock show ip fib
   ipv4-VRF:0, fib_index 0, flow hash: src dst sport dport proto 
   0.0.0.0/0
     unicast-ip4-chain
     [@0]: dpo-load-balance: [index:0 buckets:1 uRPF:0 to:[0:0]]
       [0] [@0]: dpo-drop ip4
   0.0.0.0/32
     unicast-ip4-chain
     [@0]: dpo-load-balance: [index:1 buckets:1 uRPF:1 to:[0:0]]
       [0] [@0]: dpo-drop ip4
   10.10.1.1/32
     unicast-ip4-chain
     [@0]: dpo-load-balance: [index:10 buckets:1 uRPF:9 to:[5:420] via:[1:84]]
       [0] [@5]: ipv4 via 10.10.1.1 host-vpp1out: IP4: 02:fe:48:ec:d5:a7 -> fa:13:55:ac:d9:50
   10.10.1.0/24
     unicast-ip4-chain
     [@0]: dpo-load-balance: [index:8 buckets:1 uRPF:7 to:[0:0]]
       [0] [@4]: ipv4-glean: host-vpp1out
   10.10.1.2/32
     unicast-ip4-chain
     [@0]: dpo-load-balance: [index:9 buckets:1 uRPF:8 to:[6:504]]
       [0] [@2]: dpo-receive: 10.10.1.2 on host-vpp1out
   224.0.0.0/4
     unicast-ip4-chain
     [@0]: dpo-load-balance: [index:3 buckets:1 uRPF:3 to:[0:0]]
       [0] [@0]: dpo-drop ip4
   240.0.0.0/4
     unicast-ip4-chain
     [@0]: dpo-load-balance: [index:2 buckets:1 uRPF:2 to:[0:0]]
       [0] [@0]: dpo-drop ip4
   255.255.255.255/32
     unicast-ip4-chain
     [@0]: dpo-load-balance: [index:4 buckets:1 uRPF:4 to:[0:0]]
       [0] [@0]: dpo-drop ip4
