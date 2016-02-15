*******
PROMPTS
*******

When you run ``cookiecutter </path/to/coomiecutter/template>`` you will be asked a series of questions.  These are called `prompts`.  This document details the questions you will be asked by Cookiecutter when you use it to build `django starter`_.

Templated Values
================

repo_name:
    What do you want to name your project repo?  No spaces.  Underscores or dashes only.

    `default`: my_project

project_name:
    What do you want to name the folder that holds your Django source code?

    default: src

repo_root_path:
    The path to your project.  This is for the provisioning so you can usually always leave it blank, unless you want to configure where your directory lives in Vagrant.

    default: /home/vagrant/my_project

project_root_path:
    The path to your project source code (`project_name`).  Used by your provisioning scripts.

    default: /home/vagrant/my_project/src

django_reqs_path:
    Path to your requirements directory.  Used by your provisioning scripts.

    default: /home/vagrant/my_project/requirements

django_default_settings:
    Which settings file to you want to use?  Used by provisioning scripts.

    default: config.settings.dev

virtualenv_dir_path:
    Path to your `virtualenv`. Used by provisioning scripts.

    default: /home/vagrant/.virtualenvs

db_engine:
    Which database do you want your project to use?  Postgres and sqlite are the options you have.  The project will configure correctly with whichever you choose and you can easily reconfigure the project after it's initialized if you don't like your choice.

    default: sqlite

db_user:
    Name of your postgres database user.  Not used by sqlite.

    default: dev

db_password:
    What do you want your postgres database password to be.  Not used by sqlite

    default: my_project_dev

db_host:
    The host name for your database.  This is usually always correct, so you can almost always leave this blank.

    default: localhost

db_name:
    Name of your database.

    default: my_project

os_user:
    Name of your Vagrant user.  If you did not specify, vagrant will default this to Vagrant.  This is fine, there is really no reason to change, unless you want every detail of your vagrant the same as your production server.

    default: vagrant

author_name:
    Who created this project?  Either your company name, or your personal name.  Spaces are fine here.

author_email:
    Email of the corporation of person who will be maintaining / building this project.  Correctly formatted email address required.

domain_name:
    The URL of the website that this site will live at.  No worries if you don't have it yet.  You can specify later.

license:
    Which license do you want to build this project under?  MIT, Apache and GPL are very permissive Open Source licenses.  No License you are essentially making this closed source - no one can use unless you expressly give them permission.

current_year:
    The current calendar year.  This is used in your licenses.

full_legal_name_of_project_owner:
    Your full legail name, or the full legal name of the entitiy you are creating this project for.



.. _`django starter`: https://github.com/tkjone/django-starter
