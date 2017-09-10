**********
Change Log
**********

All enhancements and patches to cookiecutter-django will be documented in this file. This project adheres to `Semantic Versioning`_.

[2017-09-10]
============

**Dependencies**

* Upgrade Django to 1.11 from 1.9

**Improved**

* README section gotchas
* Logging settings

**Added**

* Add README
* Django-debug toolbar

**Removed**

* Docs directory - too opinionated

[2016-02-27]
============

**Changed**

* .gitignore - updated to include a more detailed list of files and directories that git should ignore.

[2016-02-15]
============

**Added**

* `docs` directory - holds documentation for this project
* `docs/prompts.rst` - documents cookiecutter prompts

**Changed**

* added `.vagrant` to the `.gitignore`
* `README.rst` - updated the quickstart to reference the new `prompts.rst` file
* common.py - removed STATIC_ROOT
* prod.py - added STATIC_ROOT
* dev.py - added different location for STATIC_DIRS


[2016-02-14]
============

initial commit (@tkjone)

.. _Semantic Versioning: http://semver.org/
