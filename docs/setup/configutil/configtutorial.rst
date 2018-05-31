.. _configutil:

.. toctree::

Summary / Purpose of VPP Configuration Utility
-------------------------------------------------

The purpose of the VPP configuration utility is to allow the user to
configure VPP in a simple and safe manner. The utility takes input from
the user and then modifies the key configuration files. The user can
then examine these files to be sure they are correct and then actually
apply the configuration. The utility also includes an installation
utility and some basic tests. This utility is currently released with
release 17.10.

.. _supported-OS-for-VPP-configuration-utility:

.. list-table:: Verified and Supported Operating Systems 
   :widths: 50
   :header-rows: 1

   * - Ubuntu16.04

   * - centOS7
   
   * - RHEL7

Use
---

The installation and executing of the VPP configuration utility is
simple. First `install the python pip module <https://pip.pypa.io/en/stable/installing/>`__. Then using pip, 

Ubuntu: Install and Run
^^^^^^^^^^^^^^^^^^^^^^^

Run the terminal as root

::

    $ sudo -H bash

Afterwards, install vpp-config on root.

::

    # pip install vpp-config
    
Once vpp-config is installed simply type:

::

    # vpp-config 

    Welcome to the VPP system configuration utility

    These are the files we will modify:
        /etc/vpp/startup.conf
        /etc/sysctl.d/80-vpp.conf
        /etc/default/grub

    Before we change them, we'll create working copies in /usr/local/vpp/vpp-config/dryrun
    Please inspect them carefully before applying the actual configuration (option 3)!

    What would you like to do?

    1) Show basic system information
    2) Dry Run (Will save the configuration files in /usr/local/vpp/vpp-config/dryrun for inspection)
            and user input in /usr/local/vpp/vpp-config/configs/auto-config.yaml
    3) Full configuration (WARNING: This will change the system configuration)
    4) List/Install/Uninstall VPP.
    5) Execute some basic tests.
    9 or q) Quit

    Command: 
    and answer the questions. If you are not sure what to answer choose the
    default. 

.. note::

    For yes or no questions the capital letter designates the default.  
    For example, for a question that shows [Y/n] Y is the default.
    For numbers the default is within the brackets for example for a question that shows [1024]. 1024 is the default.   

For Developers
--------------

Modifying the code is reasonable simple. Edit and debug the code from
the root directory. In order to do this, we need a script that will copy
or data files to the proper place. This is where they end up with pip
install. 

* Ubuntu

::

    /usr/local/vpp/vpp-config

* Centos

::
    
    /usr/vpp/vpp-config
    
Run this script to copy the relevant files correctly: 

::

    ./scripts/cp-data.sh

Run this script to clean the environment. 

::

    ./scripts/clean.sh
    
.. note:: 

    This allows the developer to start from scratch.
    
Steps to Run the Utility
^^^^^^^^^^^^^^^^^^^^^^^^

These are the steps to run the utility in this environment. The scripts are meant to be run from the *root directory*.

::

    ./scripts/clean.sh
    ./scripts/cp-data.sh
    ./vpp_config.py 

When the utility is installed with pip the wrapper scripts/vpp-config is
written to /usr/local/bin. However, the starting point when debugging
this script locally is

::

    ./vpp_config.py

 Run the utility by executing (from the root directory)

 ::

    ./vpp_config.py 

The start point in the code is in vpp_config.py. Most of the work is
done in the files in ./vpplib

Uploading to PyPi
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To upload this utility to PyPi, simply do the following: 

.. note::
    Currently, I have my own account. When we want everyone to contribute we will need to change that. 

::

    $ sudo -H bash
    # cd vpp_config
    # python setup.py sdist bdist_wheel
    # twine upload dist/*

.. _uploading-to-pypi-1:

Configuration Tool Main Menu
--------------------------------------------

#. :ref:`Show basic system information <config-command-one>`
#. :ref:`Dry Run <config-command-two>`
#. :ref:`Full Configuration <config-command-three>`
#. :ref:`List/Install/Uninstall VPP <config-command-four>`
#. :ref:`Execute some basic tests <config-command-five>`

.. _config-command-one:

Command 1. Show System Information
-----------------------------------

Before Configuration
^^^^^^^^^^^^^^^^^^^^

When the utility is first started we can show the basic system
information.

::

   # vpp-config

   Welcome to the VPP system configuration utility

   These are the files we will modify:
       /etc/vpp/startup.conf
       /etc/sysctl.d/80-vpp.conf
       /etc/default/grub

   Before we change them, we'll create working copies in /usr/local/vpp/vpp-config/dryrun
   Please inspect them carefully before applying the actual configuration (option 3)!

::

   What would you like to do?

   1) Show basic system information
   2) Dry Run (Will save the configuration files in /usr/local/vpp/vpp-config/dryrun for inspection)
          and user input in /usr/local/vpp/vpp-config/configs/auto-config.yaml
   3) Full configuration (WARNING: This will change the system configuration)
   4) List/Install/Uninstall VPP.
   5) Execute some basic tests.
   9 or q) Quit

   Command: 1

   ==============================
   NODE: DUT1

   CPU:
             Model name:    Intel(R) Xeon(R) CPU E5-2667 v3 @ 3.20GHz
                 CPU(s):    32
     Thread(s) per core:    2
     Core(s) per socket:    8
              Socket(s):    2
      NUMA node0 CPU(s):    0-7,16-23
      NUMA node1 CPU(s):    8-15,24-31
            CPU max MHz:    3600.0000
            CPU min MHz:    1200.0000
                    SMT:    Enabled

   VPP Threads: (Name: Cpu Number)

   Grub Command Line:
     Current: BOOT_IMAGE=/boot/vmlinuz-4.4.0-97-generic root=UUID=d760b82f-f37b-47e2-9815-db8d479a3557 ro
     Configured: GRUB_CMDLINE_LINUX_DEFAULT=""

   Huge Pages:
     Total System Memory           : 65863484 kB
     Total Free Memory             : 56862700 kB
     Actual Huge Page Total        : 1024
     Configured Huge Page Total    : 1024
     Huge Pages Free               : 1024
     Huge Page Size                : 2048 kB

   Devices:

   Devices with link up (can not be used with VPP):
   0000:08:00.0    enp8s0f0                  I350 Gigabit Network Connection                   

   Devices bound to kernel drivers:
   0000:90:00.0    enp144s0                  VIC Ethernet NIC                                  
   0000:8f:00.0    enp143s0                  VIC Ethernet NIC                                  
   0000:84:00.0    enp132s0f0,enp132s0f0d1   Ethernet Controller XL710 for 40GbE QSFP+         
   0000:84:00.1    enp132s0f1,enp132s0f1d1   Ethernet Controller XL710 for 40GbE QSFP+         
   0000:08:00.1    enp8s0f1                  I350 Gigabit Network Connection                   
   0000:02:00.0    enp2s0f0                  82599ES 10-Gigabit SFI/SFP+ Network Connection    
   0000:02:00.1    enp2s0f1                  82599ES 10-Gigabit SFI/SFP+ Network Connection    

   No devices bound to DPDK drivers

   VPP Service Status:
     Not Installed

   ==============================

After Configuration 
^^^^^^^^^^^^^^^^^^^^^^

When we show the system information after the system is configured
notice that the VPP workers and the VPP main core is on the correct Numa
Node. Notice also that VPP is running and the interfaces are shown.

::

   What would you like to do?

   1) Show basic system information
   2) Dry Run (Will save the configuration files in /usr/local/vpp/vpp-config/dryrun for inspection)
          and user input in /usr/local/vpp/vpp-config/configs/auto-config.yaml
   3) Full configuration (WARNING: This will change the system configuration)
   4) List/Install/Uninstall VPP.
   5) Execute some basic tests.
   9 or q) Quit

   Command: 1

   ==============================
   NODE: DUT1

   CPU:
             Model name:    Intel(R) Xeon(R) CPU E5-2667 v3 @ 3.20GHz
                 CPU(s):    32
     Thread(s) per core:    2
     Core(s) per socket:    8
              Socket(s):    2
      NUMA node0 CPU(s):    0-7,16-23
      NUMA node1 CPU(s):    8-15,24-31
            CPU max MHz:    3600.0000
            CPU min MHz:    1200.0000
                    SMT:    Enabled

   VPP Threads: (Name: Cpu Number)
     vpp_main  : 8   
     vpp_wk_1  : 10  
     vpp_wk_0  : 9   
     vpp_stats : 0   

   Grub Command Line:
     Current: BOOT_IMAGE=/boot/vmlinuz-4.4.0-97-generic root=UUID=d760b82f-f37b-47e2-9815-db8d479a3557 ro
     Configured: GRUB_CMDLINE_LINUX_DEFAULT="isolcpus=8,9-10 nohz_full=8,9-10 rcu_nocbs=8,9-10"

   Huge Pages:
     Total System Memory           : 65863484 kB
     Total Free Memory             : 42048632 kB
     Actual Huge Page Total        : 8192
     Configured Huge Page Total    : 8192
     Huge Pages Free               : 7936
     Huge Page Size                : 2048 kB

   Devices:
   Total Number of Buffers: 25600

   Devices with link up (can not be used with VPP):
   0000:08:00.0    enp8s0f0                  I350 Gigabit Network Connection                   

   Devices bound to kernel drivers:
   0000:90:00.0    enp144s0                  VIC Ethernet NIC                                  
   0000:8f:00.0    enp143s0                  VIC Ethernet NIC                                  
   0000:84:00.0    enp132s0f0,enp132s0f0d1   Ethernet Controller XL710 for 40GbE QSFP+         
   0000:84:00.1    enp132s0f1,enp132s0f1d1   Ethernet Controller XL710 for 40GbE QSFP+         
   0000:08:00.1    enp8s0f1                  I350 Gigabit Network Connection                   
   0000:02:00.0    enp2s0f0                  82599ES 10-Gigabit SFI/SFP+ Network Connection    
   0000:02:00.1    enp2s0f1                  82599ES 10-Gigabit SFI/SFP+ Network Connection    

   Devices bound to DPDK drivers:
   0000:86:00.0                              82599ES 10-Gigabit SFI/SFP+ Network Connection    
   0000:86:00.1                              82599ES 10-Gigabit SFI/SFP+ Network Connection    

   Devices in use by VPP:
   Name                           Socket RXQs RXDescs TXQs TXDescs
   TenGigabitEthernet86/0/0            1    2    1024    3    1024
   TenGigabitEthernet86/0/1            1    2    1024    3    1024

   VPP Service Status:
     active (running)

   ==============================

.. _config-command-two:

Command 2. Dry Run
----------------------------

With VPP installed we can now execute a configuration dry run. This
option will create the configuration files and put them in a dryrun
directory. This directory is located for Ubuntu in
/usr/local/vpp/vpp-config/dryrun and for Centos in
/usr/vpp/vpp-config/dryrun. These files should be examined to be sure
that they are valid before actually applying the configuration with
option 3.

::

   What would you like to do?

   1) Show basic system information
   2) Dry Run (Will save the configuration files in /usr/local/vpp/vpp-config/dryrun for inspection)
          and user input in /usr/local/vpp/vpp-config/configs/auto-config.yaml
   3) Full configuration (WARNING: This will change the system configuration)
   4) List/Install/Uninstall VPP.
   5) Execute some basic tests.
   9 or q) Quit

   Command: 2

   These device(s) are currently NOT being used by VPP or the OS.

   PCI ID          Description                                       
   ----------------------------------------------------------------
   0000:86:00.0    82599ES 10-Gigabit SFI/SFP+ Network Connection    
   0000:86:00.1    82599ES 10-Gigabit SFI/SFP+ Network Connection    

   Would you like to give any of these devices back to the OS [Y/n]? y
   Would you like to use device 0000:86:00.0 for the OS [y/N]? y
   Would you like to use device 0000:86:00.1 for the OS [y/N]? y

   These devices have kernel interfaces, but appear to be safe to use with VPP.

   PCI ID          Kernel Interface(s)       Description                                       
   ------------------------------------------------------------------------------------------
   0000:90:00.0    enp144s0                  VIC Ethernet NIC                                  
   0000:8f:00.0    enp143s0                  VIC Ethernet NIC                                  
   0000:84:00.0    enp132s0f0,enp132s0f0d1   Ethernet Controller XL710 for 40GbE QSFP+         
   0000:84:00.1    enp132s0f1,enp132s0f1d1   Ethernet Controller XL710 for 40GbE QSFP+         
   0000:08:00.1    enp8s0f1                  I350 Gigabit Network Connection                   
   0000:02:00.0    enp2s0f0                  82599ES 10-Gigabit SFI/SFP+ Network Connection    
   0000:02:00.1    enp2s0f1                  82599ES 10-Gigabit SFI/SFP+ Network Connection    
   0000:86:00.0    enp134s0f0                82599ES 10-Gigabit SFI/SFP+ Network Connection    
   0000:86:00.1    enp134s0f1                82599ES 10-Gigabit SFI/SFP+ Network Connection    

   Would you like to use any of these device(s) for VPP [y/N]? y
   Would you like to use device 0000:90:00.0 for VPP [y/N]? 
   Would you like to use device 0000:8f:00.0 for VPP [y/N]? 
   Would you like to use device 0000:84:00.0 for VPP [y/N]? 
   Would you like to use device 0000:84:00.1 for VPP [y/N]? 
   Would you like to use device 0000:08:00.1 for VPP [y/N]? 
   Would you like to use device 0000:02:00.0 for VPP [y/N]? 
   Would you like to use device 0000:02:00.1 for VPP [y/N]? 
   Would you like to use device 0000:86:00.0 for VPP [y/N]? y
   Would you like to use device 0000:86:00.1 for VPP [y/N]? y

   These device(s) will be used by VPP.

   PCI ID          Description                                       
   ----------------------------------------------------------------
   0000:86:00.0    82599ES 10-Gigabit SFI/SFP+ Network Connection    
   0000:86:00.1    82599ES 10-Gigabit SFI/SFP+ Network Connection    

   Would you like to remove any of these device(s) [y/N]? 

   These device(s) will be used by VPP, please rerun this option if this is incorrect.

   PCI ID          Description                                       
   ----------------------------------------------------------------
   0000:86:00.0    82599ES 10-Gigabit SFI/SFP+ Network Connection    
   0000:86:00.1    82599ES 10-Gigabit SFI/SFP+ Network Connection    

   Your system has 32 core(s) and 2 Numa Nodes.
   To begin, we suggest not reserving any cores for VPP or other processes.
   Then to improve performance try reserving cores as needed. 

   How many core(s) do you want to reserve for processes other than VPP? [0-16][0]? 
   How many core(s) shall we reserve for VPP workers[0-4][0]? 2
   Should we reserve 1 core for the VPP Main thread? [y/N]? y

   How many active-open / tcp client sessions are expected [0-10000000][0]? 
   How many passive-open / tcp server sessions are expected [0-10000000][0]? 

   There currently 1024 2048 kB huge pages free.
   Do you want to reconfigure the number of huge pages [y/N]? y

   There currently a total of 1024 huge pages.
   How many huge pages do you want [1024 - 19414][1024]? 8192

.. _config-command-three:

Command 3. Apply Full Configuration
--------------------------------------

After the configuration files have been examined we can apply the
configuration with option 3. Notice the default is NOT to change the
grub command line. If the option to change the grub command line is
selected a reboot will be required.

::


   What would you like to do?

   1) Show basic system information
   2) Dry Run (Will save the configuration files in /usr/local/vpp/vpp-config/dryrun for inspection)
          and user input in /usr/local/vpp/vpp-config/configs/auto-config.yaml
   3) Full configuration (WARNING: This will change the system configuration)
   4) List/Install/Uninstall VPP.
   5) Execute some basic tests.
   9 or q) Quit

   Command: 3

   We are now going to configure your system(s).

   Are you sure you want to do this [Y/n]? y
   These are the changes we will apply to
   the huge page file (/etc/sysctl.d/80-vpp.conf).

   1,2d0
   < vm.nr_hugepages=1024
   4,7c2,3
   < vm.max_map_count=3096
   ---
   > vm.nr_hugepages=8192
   > vm.max_map_count=17408
   8a5
   > kernel.shmmax=17179869184
   10,15d6
   < kernel.shmmax=2147483648


   Are you sure you want to apply these changes [Y/n]? 
   These are the changes we will apply to
   the VPP startup file (/etc/vpp/startup.conf).

   ---
   > 
   >   main-core 8
   >   corelist-workers 9-10
   > 
   >   scheduler-policy fifo
   >   scheduler-priority 50
   > 
   67,68c56,66
   < # dpdk {
   ---
   > dpdk {
   > 
   >   dev 0000:86:00.0 { 
   >     num-rx-queues 2
   >   }
   >   dev 0000:86:00.1 { 
   >     num-rx-queues 2
   >   }
   >   num-mbufs 25600
   > 
   124c122
   < # }
   ---
   > }


   Are you sure you want to apply these changes [Y/n]? 

   The configured grub cmdline looks like this:
   GRUB_CMDLINE_LINUX_DEFAULT="isolcpus=8,9-10 nohz_full=8,9-10 rcu_nocbs=8,9-10"

   The current boot cmdline looks like this:
   BOOT_IMAGE=/boot/vmlinuz-4.4.0-97-generic root=UUID=d760b82f-f37b-47e2-9815-db8d479a3557 ro

   Do you want to keep the current boot cmdline [Y/n]? 

.. _config-command-four:

Command 4. List/Install/Uninstall VPP
---------------------------------------

Notice when the basic system information was shown, VPP was not
installed.

::

   VPP Service Status:
     Not Installed

   ==============================

We can now install VPP with option 4

::

   What would you like to do?

   1) Show basic system information
   2) Dry Run (Will save the configuration files in /usr/local/vpp/vpp-config/dryrun for inspection)
          and user input in /usr/local/vpp/vpp-config/configs/auto-config.yaml
   3) Full configuration (WARNING: This will change the system configuration)
   4) List/Install/Uninstall VPP.
   5) Execute some basic tests.
   9 or q) Quit

   Command: 4

   There are no VPP packages on node localhost.
   Do you want to install VPP [Y/n]? y
   INFO:root: Local Command: ls /etc/apt/sources.list.d/99fd.io.list.orig
   INFO:root:  /etc/apt/sources.list.d/99fd.io.list.orig
   INFO:root: Local Command: rm /etc/apt/sources.list.d/99fd.io.list
   INFO:root: Local Command: echo "deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io.ubuntu.xenial.main/ ./
   " | sudo tee /etc/apt/sources.list.d/99fd.io.list
   INFO:root:  deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io.ubuntu.xenial.main/ ./
   .......

.. _config-command-five:

Command 5. Execute Basic tests
------------------------------------------------

Command 1. Set IPv4 Addresses
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Once VPP is configured we can add some ip addresses to the configured
interfaces. Once this is done you should be able to ping the configured
addresses and VPP is ready to use. After this option, is run a script is
created in /usr/local/vpp/vpp-config/scripts/set_int_ipv4_and_up for
Ubuntu and /usr/vpp/vpp-config/scripts/set_int_ipv4_and_up for Centos.
This script can be used to configure the ip addresses in the future.

::

   What would you like to do?

   1) Show basic system information
   2) Dry Run (Will save the configuration files in /usr/local/vpp/vpp-config/dryrun for inspection)
          and user input in /usr/local/vpp/vpp-config/configs/auto-config.yaml
   3) Full configuration (WARNING: This will change the system configuration)
   4) List/Install/Uninstall VPP.
   5) Execute some basic tests.
   9 or q) Quit

   Command: 5

   What would you like to do?

   1) List/Create Simple IPv4 Setup
   9 or q) Back to main menu.

   Command: 1

   These are the current interfaces with IP addresses:
   TenGigabitEthernet86/0/0       Not Set              dn        
   TenGigabitEthernet86/0/1       Not Set              dn        

   Would you like to keep this configuration [Y/n]? n
   Would you like add address to interface TenGigabitEthernet86/0/0 [Y/n]? 
   Please enter the IPv4 Address [n.n.n.n/n]: 30.0.0.2/24
   Would you like add address to interface TenGigabitEthernet86/0/1 [Y/n]? y
   Please enter the IPv4 Address [n.n.n.n/n]: 40.0.0.2/24

   A script as been created at /usr/local/vpp/vpp-config/scripts/set_int_ipv4_and_up
   This script can be run using the following:
   vppctl exec /usr/local/vpp/vpp-config/scripts/set_int_ipv4_and_up


   What would you like to do?

   1) List/Create Simple IPv4 Setup
   9 or q) Back to main menu.

   Command: 1

   These are the current interfaces with IP addresses:
   TenGigabitEthernet86/0/0       30.0.0.2/24          up        
   TenGigabitEthernet86/0/1       40.0.0.2/24          up        

   Would you like to keep this configuration [Y/n]? 
