.. _developersvppconfig:

.. toctree::

================================
Developers section to vpp-config
================================

Modifying the code is reasonable simple. Edit and debug the code from
the root directory. In order to do this, we need a script that will copy
or data files to the proper place. This is where they end up with pip
install. 

On Ubuntu, the root directory is found by:

::

   # cd /usr/local/vpp/vpp-config

On Centos, the root directory is found by:

.. code-block:: console
    
   # cd /usr/vpp/vpp-config

Script: Clean the Environment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Run this script to clean the environment. 

.. code-block:: console

   # ./scripts/clean.sh
    
.. note:: 

    This allows the developer to start from scratch.

Script: Copying Relevant Files 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Run this script to copy the relevant files correctly: 

.. code-block:: console

   # ./scripts/cp-data.sh

    
Steps to Run the Utility
^^^^^^^^^^^^^^^^^^^^^^^^

These are the steps to run the utility in this environment. 
The scripts are meant to be run from the *root directory*.

.. code-block:: console

   # ./scripts/clean.sh
   # ./scripts/cp-data.sh
   # ./vpp_config.py 

When the utility is installed with pip the wrapper scripts/vpp-config is
written to /usr/local/bin. However, the starting point when debugging
this script locally is

.. code-block:: console

   # ./vpp_config.py

 Run the utility by executing (from the root directory)

.. code-block:: console

   # ./vpp_config.py 

The start point in the code is in vpp_config.py. Most of the work is
done in the files in ./vpplib

.. _uploading-to-pypi-1:

Uploading to PyPi
^^^^^^^^^^^^^^^^^

To upload this utility to PyPi, simply do the following: 

.. note::
    Currently, I have my own account. When we want everyone to contribute we will need to change that. 

.. code-block:: console

    $ sudo -H bash
    # cd vpp_config
    # python setup.py sdist bdist_wheel
    # twine upload dist/*


