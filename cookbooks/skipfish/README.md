Description
===========

Installs and configures [skipfish](https://code.google.com/p/skipfish/),
an active web application security reconnaissance tool.


Requirements
============

## Platforms:

* Ubuntu

Usage
=====

The default recipe installs skipfish to /opt/skipfish-<version>:

    { "run_list": ["recipe[skipfish]"] }

Recipes
=======

default
-------

* Installed to /opt/skipfish-2.10b
* Installed for user `msbuilder`
* Run with /opt/skipfish-2.10b/skipfish
