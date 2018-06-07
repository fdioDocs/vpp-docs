.. _pushingapatch:

===============================================
Pushing your changes to the VPP Docs Repository
===============================================

This section will cover how to fork your own branch of the `fdioDocs/vpp-docs <https://github.com/fdioDocs/vpp-docs>`_ repository, clone that repo locally to your computer, make changes to it, see those changes on `Read the Docs <https://readthedocs.org/>`_, and how to issue a pull request when you want your changes to be reflected on the main repo.
 

.. toctree::

Forking your own branch 
------------------------
In your browser, navigate to the repo you want to branch off of. In this case, the `fdioDocs/vpp-docs <https://github.com/fdioDocs/vpp-docs>`_ repo. At the top right of the page you should see this:

.. figure:: /_images/ForkButtons.png
   :alt: Figure: Repository options on Github 
   :scale: 50%
   :align: right

|
|
|

Click on "Fork", and then a pop-up should appear where you should then click your Github username. Once this is done, it should automatically take you to the Github page where your new branch is located, just like in the image below.

.. figure:: /_images/usernameFork.png
   :alt: Figure: Your own branch of the main repo on Github
   :scale: 35%
   :align: center


Now your **own branch** can be **cloned** to your computer using the URL (https://github.com/YOURUSERNAME/vpp-docs) of the Github page where your branch is located.


Creating a local repository
---------------------------

Now that you have your own branch of the main repository on Github, you can store it locally on your computer. In your shell, navigate to the directory where you want to store your branch/repo. Then execute:

.. code-block:: shell

   $ git clone https://github.com/YOURUSERNAME/vpp-docs

This will create a directory on your computer named **vpp-docs**, the name of the repo.

Now that your branch is on your computer, you can modify and build files however you wish.

Building required files
-----------------------

FD.io VPP Documentation uses `reStructuredText <http://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html>`_ (rst) files, which are used by `Sphinx <http://www.sphinx-doc.org/en/master/>`_. You should install Sphinx `here <http://www.sphinx-doc.org/en/master/usage/installation.html>`_, and follow their `getting started guide <http://www.sphinx-doc.org/en/master/usage/quickstart.html>`_.

Building these files will generate an **index.html** file, which you can then view in your browser to verify and see your file changes.


To *build* your files, make sure you're in your **vpp-docs/docs** directory, where your **conf.py** file is located, and run:

.. code-block:: shell

   $ make html


| If there are no errors during the build process, you should now have an **index.html** file in your
| **vpp-docs/docs/_build/html** directory, which you can then view in your browser.

.. figure:: /_images/htmlBuild.png
   :alt: Figure: My directory containing the index.html file
   :scale: 35%
   :align: center

Whenever you make changes to your **.rst** files that you want to see, repeat this build process.


Pushing to your remote branch
-----------------------------

The following talks about remote branches, but keep in mind that there are currently *two* branches, your local "master" branch (on your computer), and your remote "origin or origin/master" branch (the one you created using "Fork" on the Github website).

You can view your *remote* repositories with:

.. code-block:: shell

   $ git remote -v

At this point, it should only show us the remote branch that you cloned from.


.. figure:: /_images/showRemotes.png
   :scale: 45%
   :align: left   

|
|
|

Now you want to create a new remote repository of the main vpp-docs repo (naming it upstream).

.. code-block:: shell

   $ git remote add upstream https://github.com/fdioDocs/vpp-docs


You can verify that you have added a remote repo using the previous **git remote -v** command.

.. figure:: /_images/showBothRemotes.png
   :scale: 45%
   :align: left

|
|
|
|


If there have been any changes to the main repo since you've started working and modifying your own branch (hopefully not the same files you were working on!), you want to make sure they are in sync (excluding your modified files).

To do so, fetch any changes that the main repo has made, and then merge them into your local master branch using:

.. code-block:: shell

   $ git fetch upstream
   $ git merge upstream/master


At this point, the files you weren't working on are synced with your remote branch, and you're ready to move these changes onto your remote branch.

You now want to add each modified file, commit, and push them from *your local branch* to your *personal remote branch* (not the main fdioDocs repo).

To add files (use **git add -A** to add all modified files):

.. code-block:: shell

   $ git add FILENAME1 FILENAME2

Commit and push using: 

.. code-block:: shell

   $ git commit -m 'A descriptive commit message for two files.'
   $ git push origin master

Here, your personal remote branch is "origin" and your local branch is "master".

.. note::

    Using **git commit** after adding your files saves a "Snapshot" of them, so it's very hard to lose your work if you *commit often*.



Initiating a pull request for the main branch
---------------------------------------------

Do we first click "New pull request" on the main fdioDocs page????

Now you can go to the main fdioDocs repo on the Github page (not your branch), and click on "Compare & pull request" to go through the process of initiating a pull request.

!!!!!TO-DO ADD PICTURES!!!!!!


Getting the Latest Sources
--------------------------

.. code-block:: console

    git reset --hard origin/master
    git checkout master

.. _fdioDocs: https://github.com/fdioDocs/vpp-docs

