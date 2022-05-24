===================
danesfield-coverage
===================

Tool for testing coverage of Kitware's
`Danesfield <https://github.com/Kitware/Danesfield>`_ project using `coverage.py
<https://coverage.readthedocs.io/>`_.

Configuration
=============

Environment
-----------

Before using the tool you have to edit ``conda_source_dir`` in `<coverage.sh>`_
to reflect your conda base environment path. For this tool, it is set to
``~/miniconda3`` by default, however your conda base environment may be
located elsewhere.

To get your conda base environment directory you can run ``conda info`` and copy
the value from ``base environment : <...>``.

Git
---

You can configure the git remote/branch by modifying the ``dashboard_git_url``
and ``dashboard_git_branch`` values respectively.

Usage
=====

To generate a coverage report run:

.. code-block::

    ./coverage.sh

The shell script generates a html coverage report located in the ``htmlcov``
directory.

Note:
-----

By default, the script will try to create/update the Danesfield `conda environment
<https://github.com/Kitware/Danesfield/blob/master/deployment/conda/README.rst>`_
and install the ``coverage`` module. This process takes time, so if you want to
skip the conda validation (*if your environment is already up to date*) you can
use the ``-s`` or ``--skip`` flags:

.. code-block::

    ./coverage.sh -s
