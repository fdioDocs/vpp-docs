.. _VagrantVMSetup:

.. toctree::

Accessing your VM
^^^^^^^^^^^^^^^^^
ssh into your newly created box:

.. code-block:: shell

    $ vagrant ssh <id>

Now you're in your VM.

.. code-block:: console

  $ vagrant ssh c1c
  Welcome to Ubuntu 16.04 LTS (GNU/Linux 4.4.0-21-generic x86_64)

   * Documentation:  https://help.ubuntu.com/
  Last login: Mon Jun 25 08:05:38 2018 from 10.0.2.2
  vagrant@localhost:~$


.. note::
  
  Type **exit** if you want to exit your VM, or container (which we'll get to soon.)

Become the root with:

.. code-block:: shell

    $ sudo bash


Now we want to install some packages for using our containers, such as lxc:

.. code-block:: shell

  ~# apt-get install bridge-utils lxc


After this is done, we now want to *install* VPP in the VM. Keep in mind that VPP has been built based on the commands in *build.sh*, but not yet installed.

When you ssh into your Vagrant box you will be placed in the directory */home/vagrant*. Change directories to */vpp/build-root*, and run these commands to install VPP based on your OS and architechture:

For Ubuntu systems:

.. code-block:: shell
    
    ~# dpkg -i *.deb

For CentOS systems:

.. code-block:: shell
    
    ~# rpm -Uvh *.rpm


Since VPP is now installed, we can start running VPP on our "host" VM with:

.. code-block:: shell
  
  ~# service vpp start 