.. _pushingapatch:

=============================================
Pushing a patch to the VPP Documentation
=============================================

.. toctree::


Pushing a Patch
===========================

I build and load the documents using a mac, but these instuctions should be portable
to any platform. I used the Python virtual environment.

1. Review the changes

.. code-block:: console

    git status

2. Specify which files that will be pushed

.. code-block:: console

    git add <filename>

3. Commit the changes locally

.. code-block:: console

    git commit -s

4. Submit the changes for review

.. code-block:: console

    git review

Reviewing a Patch
===========================

1. Getting the patch for review

.. code-block:: console

    git review -d <review number>

1. Look at the changes

.. code-block:: console

    git status

2. Edit the changes you would like to add

3. Specify which files you changed

.. code-block:: console

    git add <filename>

4. Commit the changes locally

.. code-block:: console

    git commit --amend -s

5. Submit the changes for review

.. code-block:: console

    git review

Getting the Latest Sources
===========================

.. code-block:: console

    git reset --hard origin/master
    git checkout master

