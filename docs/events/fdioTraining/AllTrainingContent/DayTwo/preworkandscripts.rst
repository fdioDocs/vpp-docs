.. _preworkandscripts:

.. toctree::

#########################################
FD.io DevBoot: Day 2 Pre-work and scripts
#########################################

Event
-----

This presentation was held on April, 2016.

Preparing for Day 2
-------------------

#. :ref:`Set up your repo/ dev environment <reference/vppcontainers/installingVboxVagrant>`
#. Build vagrant environment

.. code-block:: python
    
    $ vagrant ssh 
    $ sudo su
    $ wget -O /vagrant/netns.sh "https://tinyurl.com/devboot-netns"
    $ wget -O /vagrant/macswap.conf "https://tinyurl.com/devboot-macswap-conf"
    $ wget -O ~/.gdbinit "https://tinyurl.com/devboot-gdbinit"

For Init section:
Breakpoints
High-level chicken-scrawl of init


