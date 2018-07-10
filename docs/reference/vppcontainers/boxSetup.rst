.. _boxSetup:

.. toctree::


Box configuration 
=================


Looking at the :ref:`vppVagrantfile`, we can see that the default OS is Ubuntu 16.04 (because if there is no ENV distro variable set, the last case - the **else** case - is executed):

.. code-block:: ruby

    # -*- mode: ruby -*-
    # vi: set ft=ruby :

    Vagrant.configure(2) do |config|

      # Pick the right distro and bootstrap, default is ubuntu1604
      distro = ( ENV['VPP_VAGRANT_DISTRO'] || "ubuntu1604")
      if distro == 'centos7'
        config.vm.box = "centos/7"
        config.vm.box_version = "1708.01"
        config.ssh.insert_key = false
      elsif distro == 'opensuse'
        config.vm.box = "opensuse/openSUSE-42.3-x86_64"
        config.vm.box_version = "1.0.4.20170726"
      else
        config.vm.box = "puppetlabs/ubuntu-16.04-64-nocm"

As mentioned above, you can specify which OS and VM provider you want on the `Vagrant boxes page <https://app.vagrantup.com/boxes/search>`_.

Next in the Vagrantfile, you can see some *config.vm.provision* commands. As paraphrased from `Basic usage of Provisioners <https://www.vagrantup.com/docs/provisioning/basic_usage.html>`_, by default these are only run one time - during the *first* boot of the box.

.. code-block:: ruby

    config.vm.provision :shell, :path => File.join(File.dirname(__FILE__),"update.sh")
    config.vm.provision :shell, :path => File.join(File.dirname(__FILE__),"build.sh"), :args => "/vpp vagrant"

The Vagrantfile sets the box to run two scripts during the first bootup: an update script *update.sh* that does basic updating and installation of some useful tools, as well as a *build.sh* script that builds (but does **not** install) VPP for your box.

.. _manualCmds:

.. note::
  
  If you prefer to update your box and build VPP on it manually, you can remove the two lines above from the Vagrantfile. To build VPP, refer to these commands that you would perform once you have ssh'ed into your box:
  :ref:`building VPP commands section <buildingcommands>`

Looking further in the :ref:`vppVagrantfile` you can see more of the ENV's being used (and a default value if they're not set):

.. code-block:: ruby

    # Define some physical ports for your VMs to be used by DPDK
    nics = (ENV['VPP_VAGRANT_NICS'] || "2").to_i(10)
    for i in 1..nics
      config.vm.network "private_network", type: "dhcp"
    end

    # use http proxy if avaiable
    if ENV['http_proxy'] && Vagrant.has_plugin?("vagrant-proxyconf")
     config.proxy.http     = ENV['http_proxy']
     config.proxy.https    = ENV['https_proxy']
     config.proxy.no_proxy = "localhost,127.0.0.1"
    end

    vmcpu=(ENV['VPP_VAGRANT_VMCPU'] || 2)
    vmram=(ENV['VPP_VAGRANT_VMRAM'] || 4096)


You can see how the box is configured, such as the amount of NICs (defaults to 3 NICs: 1 x NAT - host access and 2 x VPP DPDK enabled), CPUs (defaults to 2), and RAM (defaults to 4096 MB).


Box provisioning
________________


Once you're satisfied with your **Vagrantfile**, to boot the box run:

.. code-block:: shell

    $ vagrant up

Doing this above command may take quite some time, since you are installing a VM. Take a break and get some scooby snacks.

To confirm it is up, we can do: 

.. code-block:: shell

  $ vagrant global-status

You will have only one machine running, but I have multiple as shown below:

.. code-block:: console

  [centos@dskl09 vpp-userdemo]$ vagrant global-status
  id       name    provider   state    directory                                           
  -----------------------------------------------------------------------------------------
  d90a17b  default virtualbox poweroff /home/centos/andrew-vpp/vppsb/vpp-userdemo          
  77b085e  default virtualbox poweroff /home/centos/andrew-vpp/vppsb2/vpp-userdemo         
  c1c8952  default virtualbox poweroff /home/centos/andrew-vpp/testingVPPSB/extras/vagrant 
  c199140  default virtualbox running  /home/centos/andrew-vpp/vppsb3/vpp-userdemo 


.. note::

  To poweroff your VM, type:

  .. code-block:: shell

     $ vagrant halt <id>

  To resume your VM, type:

  .. code-block:: shell

     $ vagrant resume <id>
     
  To destroy your VM, type:

  .. code-block:: shell

     $ vagrant destroy <id>

  For other commands, visit the `Vagrant CLI Page <https://www.vagrantup.com/docs/cli/>`_.