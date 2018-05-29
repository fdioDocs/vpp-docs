.. _ubuntu:

.. toctree::

The fd.io repo
--------------------------------

**1. Pick the Ubuntu version**

* Ubuntu 16.04 - Xenial

.. code-block:: console

   export UBUNTU="xenial"

**2. Pick the VPP version**

* Latest VPP Release

.. code-block:: console

  unset -v RELEASE

* Latest VPP 18.04 Throttle Branch

.. code-block:: console

  export RELEASE=".stable.1804"

* Latest VPP 18.01 Throttle Branch

.. code-block:: console

  export RELEASE=".stable.1801"

* Latest VPP 17.10 Throttle Branch

.. code-block:: console

  export RELEASE=".stable.1710"

* Latest VPP 17.07 Throttle Branch

.. code-block:: console

  export RELEASE=".stable.1707"

* MASTER (in development)

.. code-block:: console

  export RELEASE=".master"

**3. To write the fd.io sources list execute:**

.. code-block:: console

  sudo rm /etc/apt/sources.list.d/99fd.io.list
  echo "deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io$RELEASE.ubuntu.$UBUNTU.main/ ./" | sudo tee -a /etc/apt/sources.list.d/99fd.io.list

Install the mandatory packages
--------------------------------

.. code-block:: console

  sudo apt-get update
  sudo apt-get install vpp vpp-lib vpp-plugin

Install the optional packages
--------------------------------

.. code-block:: console

  sudo apt-get install vpp-dbg vpp-dev vpp-api-java vpp-api-python vpp-api-lua

Uninstall the packages
--------------------------------

.. code-block:: console

  sudo apt-get remove --purge vpp*
