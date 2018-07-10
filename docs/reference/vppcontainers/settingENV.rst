.. _settingENV:

.. toctree::


Setting your ENV(Environment) Variables
=======================================


The :ref:`vppVagrantfile` used in the VPP repo sets the configuration options based on your ENV variables (or to default at some value if you did not set them).

Below is the *env.sh* script found in *vpp/extras/vagrant* that sets ENV variables using the **export** command.

.. code-block:: bash

    export VPP_VAGRANT_DISTRO="ubuntu1604"
    export VPP_VAGRANT_NICS=2
    export VPP_VAGRANT_VMCPU=4
    export VPP_VAGRANT_VMRAM=4096 

In the :ref:`vppVagrantfile`, you can see these same ENV variables used (discussed on the next page).

Adding your own ENV variable is easy. For example, if you wanted to setup proxies for your VM, you would add lines in this script containing the **export** commands found in the :ref:`building VPP commands section <buildingcommands>`. Note that this only works if the ENV variable is defined in the :ref:`vppVagrantfile`.

Once you're finished with your *env.sh* script, and you're in the directory containing the script, *run* the script to define the ENV variables with:

.. code-block:: shell
   
   $ source ./env.sh