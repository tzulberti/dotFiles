sudo apt-get update
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





# ahora estas cosas las hago para poder tener configurado el bash como a mi me gusta
cd /media/data/Proyectos/dotFiles
ln -sf $(pwd)/bashrc ~/.bashrc
ln -sf $(pwd)/vimrc ~/.vimrc
ln -sf $(pwd)/bash_aliases ~/.bash_aliases
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/pydistutils.cfg ~/.pydistutils.cfg
ln -sf $(pwd)/screenrc ~/.screenrc
ln -sf $(pwd)/sqliterc ~/.sqliterc


# crear los virtuale-envs correspondientes
virtualenv --no-site-packages ~/envs/entrenamiento

cd /media/data/Proyectos/entrenamiento-arqueria
~/envs/entrenamiento/bin/pip install -e .

# esto lo tengo que hacer para todos los proyectos


# TODO falta el jDownloader y java, y go, rust
