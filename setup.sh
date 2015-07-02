sudo apt-get update
sudo apt-get install -y chromium-browser
sudo apt-get install -y htop vim exuberant-ctags unzip unrar

# todas las cosas que necesito para poder trabajar en los diferentes
# proyectos.
sudo apt-get install -y python-dev setuptools build-essential
sudo easy_install pip
sudo easy_install --upgrade setuptools
sudo pip install virtualenv

sudo apt-get install -y libxml2-dev libxslt-dev python-dev zlib1g-dev
sudo apt-get install -y libtiff4-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.5-dev tk8.5-dev

# se encarga de instalar todo lo relacionado a la base de datos
sudo apt-get install -y postgresql libpq-dev pgadmin3

# se encarga de instalar todo lo necesario para que me funcionen los diferentes proyectos de wine
sudo apt-get install -y ia32-libs-multiarch libtxc-dxtn-s2tc0:i386 wine

# configuro el virtualbox
sudo echo "deb http://download.virtualbox.org/virtualbox/debian saucy contrib" > /etc/apt/sources.list
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y virtualbox-4.3


sudo mkdir /media/data
sudo mkdir /media/otros
sudo echo "/dev/sda5	/media/data	ext4	rw,nosuid,nodev,uhelper=udisks2" > /etc/fstab
sudo echo "/dev/sda6	/media/otros	ext4	rw,nosuid,nodev,uhelper=udisks2" > /etc/fstab

sudo mount /media/data
sudo mount /media/otros

# ahora estas cosas las hago para poder tener configurado el bash como a mi me gusta
cd /media/data/Proyectos/dotFiles

# para tenga en cuenta el tema de los hooks de git
mkdir -p ~/.git_template/hooks
chmod +x $(pwd)/pre-commit.py

ln -s `pwd`/bashrc ~/.bashrc
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/bash_aliases ~/.bash_aliases
ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/pydistutils.cfg ~/.pydistutils.cfg
ln -s `pwd`/screenrc ~/.screenrc
ln -s `pwd`/sqliterc ~/.sqliterc
ln -s $(pwd)/pre-commit.py ~/.git_template/hooks/pre-commit


# crear los virtuale-envs correspondientes
virtualenv --no-site-packages ~/envs/entrenamiento

cd /media/data/Proyectos/entrenamiento-arqueria
~/envs/entrenamiento/bin/pip install -e .

# esto lo tengo que hacer para todos los proyectos


# TODO falta el jDownloader y java, y go
sudo apt-get -y install software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get -y install oracle-java7-installer
