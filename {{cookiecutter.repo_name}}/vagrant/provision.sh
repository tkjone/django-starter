#-------------------------------------------------------------
# CONFIGS
#-------------------------------------------------------------

repo_name="{{ cookiecutter.repo_name }}"
project_name="{{ cookiecutter.project_name }}"
repo_dir="{{cookiecutter.repo_root_path}}"
project_dir="{{ cookiecutter.project_root_path }}"
django_reqs="{{ cookiecutter.django_reqs_path }}"
virtualenv_dir="{{ cookiecutter.virtualenv_dir_path }}"
db_engine="{{cookiecutter.db_engine}}"
db_user="{{cookiecutter.db_user}}"
db_password="{{cookiecutter.db_password}}"
db_host="{{cookiecutter.db_host}}"
db_name="{{cookiecutter.db_name}}"
os_user="{{cookiecutter.os_user}}"
python_2="/usr/bin/python"
python_3="/usr/bin/python3"
software=(
    "python-pip"

    {% if cookiecutter.db_engine == "postgres" -%}

    "expect"
    "python-dev"
    "python3-dev"
    "postgresql"
    "postgresql-contrib"
    "libpq-dev"

    {% endif %} )
log_color="\e[1;36m"

#-------------------------------------------------------------
# UTILITIES
#-------------------------------------------------------------


#    SUMMARY:  Logging Utility
#    EXAMPLE:  logit "This is a console log"
#    PARAMETERS:
#       MSG - enter a string that you want logit to log
logit () {
    echo -e "${log_color} $1"
}


#-------------------------------------------------------------
# INSTALL SOFTWARE
#-------------------------------------------------------------

# INFO: update ubuntu
logit "Updating Ubuntu"
sudo apt-get update

# install software
for i in "${software[@]}"
do
   logit "Installing $i"
   sudo apt-get install -y $i
done

# INFO: install virtualenvwrapper
logit "Installing virtualenvwrapper"
sudo pip install virtualenvwrapper

#-------------------------------------------------------------
# CONFIGURE VIRTUALENVWRAPPER
#-------------------------------------------------------------

# INFO: configuring .profile
logit "configuring .profile"
sed -i '10i # virtualenvwrapper configuration' /home/vagrant/.profile
sed -i '11i export WORKON_HOME=/home/vagrant/.virtualenvs' /home/vagrant/.profile
sed -i '12i source /usr/local/bin/virtualenvwrapper.sh' /home/vagrant/.profile

# INFO: relaod .profile
logit "Reloading .profile"
source /home/vagrant/.profile


{% if cookiecutter.db_engine == "postgres" -%}
#-------------------------------------------------------------
# SETUP DATABASE
#-------------------------------------------------------------

# setup database
logit "setting up project database"
expect ${repo_dir}/vagrant/expects/set_db.exp ${db_name} ${db_user} ${db_password} ${os_user}

{% endif %}
#-------------------------------------------------------------
# CREATE VIRTUAL ENVIRONMENTS
#-------------------------------------------------------------

# INFO: initialize virtualenvironment - Python 2
logit "Creating ${repo_name} Python 2 virtual environment"
mkvirtualenv -r ${django_reqs} ${repo_name}2

# INFO: initialize virtualenvironment - Python 3
logit "Creating ${repo_name} Python 3 virtual environment..."
mkvirtualenv -r ${django_reqs} --python=${python_3} ${repo_name}3

# setup the python path and django_settings_module
logit "Configuring postactivate hook for virtualenv..."
cat << EOF >> ${virtualenv_dir}/postactivate
    # django settings
    export PYTHONPATH="$PYTHONPATH:${repo_dir}"
    export DJANGO_SETTINGS_MODULE="config.settings.dev"
EOF

# remove django_settings_module when user deactivate virtualenv
logit "Configuring postdeactivate hook for virtualenv..."
cat << EOF >> ${virtualenv_dir}/postdeactivate
    # unset project environment variables
    unset DJANGO_SETTINGS_MODULE
EOF

#-------------------------------------------------------------
# DJANGO SETUP
#-------------------------------------------------------------

# INFO: activate virtualenv
logit "Activate virtual environment"
source ${virtualenv_dir}/${repo_name}3/bin/activate

# INFO: move into django project
logit "Changing ${repo_name} folder"
cd ${repo_name}

# INFO: log user into virtualenv when they ssh into VM
logit "Configuring .bashrc"
cat << EOF >> /home/vagrant/.bashrc
    # login to virtualenv
    workon ${repo_name}3
    # project directory
    cd ${repo_dir}
    export PYTHONDONTWRITEBYTECODE=1
EOF

# INFO: move into django project
logit "Changing to ${repo_name} directory"
cd ${repo_dir}

# INFO: build initial Django DB tables
logit "Migrating Django DB"
python manage.py migrate

#-------------------------------------------------------------
# CREATE SUPER USER
#-------------------------------------------------------------
# createsuperuser
logit "creating project superuser"
expect $repo_dir/vagrant/expects/set_admin.exp ${os_user} ${repo_name} ${repo_dir} ${db_user} {{cookiecutter.author_email}} ${db_password}

logit "provisioning complete"
