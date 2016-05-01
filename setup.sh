# agrego los repositorios que necesito para Java y Virtualbox
sudo add-apt-repository ppa:webupd8team/java
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

# tengo que actualizar para que fetchee los nuevos repos
sudo apt-get update

# paquetes comunes que uso siempre
sudo apt-get install -y htop vim exuberant-ctags unzip unrar curl
sudo apt-get install -y git mercurial subversion
sudo apt-get install -y mplayer easytag

# lo tengo que instalar primero porque me pregunta de confirmar
sudo apt-get install -y oracle-java8-installer

# ahora instalo el virtualbox
sudo apt-get install -y virtualbox-5.0

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
sudo apt-get install -y ia32-libs-multiarch libtxc-dxtn-s2tc0:i386 wine playonlinux

# las librerias que uso por el tema de lxml y estas yerbas
sudo apt-get install -y gfortran libatlas-base-dev libatlas3gf-base
sudo apt-get install -y libjpeg-dev libxml2-dev libfreetype6-dev
sudo apt-get install -y libpng-dev libxslt1-dev
sudo apt-get install -y libffi-dev

# porque usamos shapely
sudo apt-get install -y libgeos-c1 libgdal-dev

# instalo nodejs y todas las cosas necesarias para los proyectos que
# hicimos en vertice
sudo apt-get install -y npm nodejs
sudo npm install -g grunt-cli 
sudo npm install -g bower

# por un problema con bower
sudo ln -s /usr/bin/nodejs /usr/bin/node

# setup de rust
curl -sSf https://static.rust-lang.org/rustup.sh | sh


# ahora estas cosas las hago para poder tener configurado el bash como a mi me gusta
cd /media/data/Proyectos/dotFiles

# para tenga en cuenta el tema de los hooks de git
mkdir -p ~/.git_template/hooks
chmod +x $(pwd)/pre-commit.py


mkdir -p ~/.config/gtk-3.0/

ln -sf $(pwd)/bashrc ~/.bashrc
ln -sf $(pwd)/vimrc ~/.vimrc
ln -sf $(pwd)/bash_aliases ~/.bash_aliases
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/pydistutils.cfg ~/.pydistutils.cfg
ln -sf $(pwd)/screenrc ~/.screenrc
ln -sf $(pwd)/sqliterc ~/.sqliterc
ln -sf $(pwd)/pre-commit.py ~/.git_template/hooks/pre-commit
ln -sf $(pwd)/gtk.css  ~/.config/gtk-3.0/gtk.css


# bajo todas las dependencias de bower y esas cosas para ditella
cd /media/data/Proyectos/ditella-scrapping-web
npm install
bower install


cd /media/data/Proyectos/entrenamiento-arqueria
virtualenv --no-site-packages ~/envs/entrenamiento
~/envs/entrenamiento/bin/pip install -e .

# TODO esto lo tengo que hacer para todos los proyectos
cd /media/data/Proyectos/ditella-scrapping-lotes-backend
virtualenv --no-site-packages ~/envs/lotes
~/envs/lotes/bin/pip install -e .



# TODO falta instalar JDownloader, maven, go
