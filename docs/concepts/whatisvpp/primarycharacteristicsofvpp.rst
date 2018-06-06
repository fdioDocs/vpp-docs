.. _primarycharacteristicsofvpp:

.. toctree::

Primary Characteristics Of FD.io VPP
*************************************

Improved fault-tolerance and ISSU
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Improved fault-tolerance and ISSU when compared to running similar
packet processing in the kernel:

* crashes seldom require more than a process restart
* software updates do not require system reboots
* development environment is easier to use and perform debug than similar kernel code
* user-space debug tools (gdb, valgrind, wireshark)
* leverages widely-available kernel modules (uio, igb_uio): DMA-safe memory

Runs as a Linux user-space process:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* same image works in a VM, in a Linux container, or over a host kernel
* KVM and ESXi: NICs via PCI direct-map
* Vhost-user, netmap, virtio paravirtualized NICs
* Tun/tap drivers
* DPDK poll-mode device drivers

Integrated with the DPDK, FD.io VPP supports existing NIC devices including:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Intel i40e, Intel ixgbe physical and virtual functions, Intel e1000, virtio, vhost-user, Linux TAP
* HP rebranded Intel Niantic MAC/PHY
* Cisco VIC

Security issues considered:
^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Extensive white-box testing by Cisco's security team
* Image segment base address randomization
* Shared-memory segment base address randomization
* Stack bounds checking
* Debug CLI "chroot"

The vector method of packet processing has been proven as the primary
punt/inject path on major architectures.