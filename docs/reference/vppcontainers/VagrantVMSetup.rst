.. _twocontainers:

.. toctree::

=====================================
VPP with two Containers using Vagrant
=====================================

Accessing your VM
^^^^^^^^^^^^^^^^^
Lets ssh into our newly created box:

.. code-block:: shell

    $ vagrant ssh <id>

Now you're in your VM.

.. code-block:: console

  [[centos@dskl09 vpp-userdemo]$ vagrant ssh c1c
  Welcome to Ubuntu 16.04 LTS (GNU/Linux 4.4.0-21-generic x86_64)

   * Documentation:  https://help.ubuntu.com/
  Last login: Mon Jun 25 08:05:38 2018 from 10.0.2.2
  vagrant@localhost:~$


.. note::
  
  Type **exit** if you want to exit your VM, or container (which we'll get to soon.)


Let's set up the hugepages:

.. code-block:: shell
  
  $ sysctl -w vm.nr_hugepages=1024


.. code-block:: console 
  
  vagrant@localhost:~ sysctl: permission denied on key 'vm.nr_hugepages'

Oh no! What happened? We're not root. Lets change to root.

.. code-block:: shell

  $ sudo bash

Then we can perform the previous sysctl command with no issues.

To check if it was set correctly:

.. code-block:: shell

  $ HUGEPAGES=`sysctl -n  vm.nr_hugepages`
  $ echo $HUGEPAGES

Which should output 1024. 

Now we want to add the VPP repo as to our sources list in our VM. We append the FD.io binary repo to a file called 99fd.io.list, so *apt-get* *update* and *install* can use it:

.. code-block:: shell

    ls /etc/apt # here is where you can see your sources.list.d directory after doing this command below

    echo "deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io.ubuntu.xenial.main/ ./" | sudo tee -a /etc/apt/sources.list.d/99fd.io.list

  

Do an *apt-get* to make sure the VM and its libraries are updated:

.. code-block:: shell
  
  $ apt-get update

Now we want to install VPP and lxc (for our containers):

.. code-block:: shell

  $ apt-get install vpp vpp-lib vpp-dpdk-dkms bridge-utils lxc
  

Now we can start running VPP on our host VM:


.. code-block:: shell
  
  $ service vpp start 


Check if we installed lxc:

.. code-block:: shell
  
   $ lxc-checkconfig






