.. _ndrrates:

.. toctree::
    
NDR Rates 
***********************************

NDR rates for 2p10GE, 1 core, L2 NIC-to_NIC
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following chart shows the NDR rates on: 2p10GE, 1 core, L2
NIC-to_NIC.

.. figure:: /_images/Vpp_performance_barchart_ndr_rates_l2-nic-to-nic.jpg
   :alt: NDR rate for 2p10GE, 1 core, L2 NIC-to_NIC 

   NDR rate for 2p10GE, 1 core, L2 NIC-to_NIC

NDR rates for 2p10GE, 1 core, L2 NIC-to-VM/VM-to-VM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


The following chart shows the NDR rates on: 2p10GE, 1 core, L2
NIC-to-VM/VM-to-VM .

.. figure:: /_images/VPP_performance_barchart_ndr_rates_l2-nic-to-VM.small.jpg
   :alt: NDR rates for 2p10GE, 1 core, L2 NIC-to-VM/VM-to-VM

   NDR rates for 2p10GE, 1 core, L2 NIC-to-VM/VM-to-VM

..

     NOTE:

    * Virtual network infra benchmark of efficiency
    * All tests per connection only, single core
    * Potential higher performance with more connections, more cores
    * Latest SW: OVSDPDK 2.4.0, FD.io VPP 09/2015

NDR rates FD.io VPP versus OVSDPDK
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following chart show FD.io VPP performance compared to open-source and
commercial reports.

The rates reflect FD.io VPP and OVSDPDK performance tested on Haswell x86
platform with E5-2698v3 2x16C 2.3GHz. The graphs shows NDR rates for 12
port 10GE, 16 core, IPv4.

.. figure:: /_images/VPP_and_ovsdpdk_tested_on_haswellx86_platform.jpg
   :alt: VPP and OVSDPDK Comparison

   FD.io VPP and OVSDPDK Comparison
