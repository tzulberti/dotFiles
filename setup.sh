# If there is some kind of error stop
set -e
set -u


# file paths
echo 'UUID=48c26bd7-a385-439f-ad98-f80e947d1e60   /media/data       ext4    rw,nosuid,nodev,uhelper=udisks2'  | sudo tee --append /etc/fstab
sudo mkdir /media/data
sudo mount /media/data

# para que no me pregunte nada al instalar Java
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

# tengo que actualizar para que fetchee los nuevos repos
sudo apt-get update

# para que valide el tema del setup de docker
sudo apt-get install -y apt-transport-https ca-certificates

# agrego los repositorios que necesito para Java, Virtualbox y Docker
sudo add-apt-repository ppa:webupd8team/java
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -


echo 'deb http://download.virtualbox.org/virtualbox/debian xenial contrib' | sudo tee --append /etc/apt/sources.list
echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' | sudo tee --append /etc/apt/sources.list
sudo apt-get update

# paquetes comunes que uso siempre
sudo apt-get install -y htop vim exuberant-ctags unzip unrar curl chromium-browser vim-nox
sudo apt-get install -y git mercurial subversion
sudo apt-get install -y mplayer easytag mpv mediainfo

# lo tengo que instalar primero porque me pregunta de confirmar
sudo apt-get install -y oracle-java8-installer

# ahora instalo el virtualbox
sudo apt-get install -y virtualbox-5.1

# todas las cosas que necesito para poder trabajar en los diferentes
# proyectos.
sudo apt-get install -y python-dev python-setuptools build-essential
sudo easy_install pip
sudo easy_install --upgrade setuptools
sudo pip install virtualenv

sudo apt-get install -y libxml2-dev libxslt-dev python-dev zlib1g-dev
sudo apt-get install -y libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.5-dev tk8.5-dev

# se encarga de instalar todo lo relacionado a la base de datos
sudo apt-get install -y postgresql libpq-dev pgadmin3

# se encarga de instalar todo lo necesario para que me funcionen los diferentes proyectos de wine
sudo apt-get install -y ia32-libs-multiarch 
sudo apt-get install -y libtxc-dxtn-s2tc0:i386 wine playonlinux

# las librerias que uso por el tema de lxml y estas yerbas
sudo apt-get install -y gfortran libatlas-base-dev libatlas3-base ack-grep
sudo apt-get install -y libjpeg-dev libxml2-dev libfreetype6-dev
sudo apt-get install -y libpng-dev libxslt1-dev
sudo apt-get install -y libffi-dev

# porque usamos shapely
sudo apt-get install -y libgeos-c1v5 libgdal-dev

# instalo nodejs y todas las cosas necesarias para los proyectos que
# hicimos en vertice
sudo apt-get install -y npm nodejs
sudo npm install -g grunt-cli 
sudo npm install -g bower

# por un problema con bower
sudo ln -s /usr/bin/nodejs /usr/bin/node

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
ln -sf $(pwd)/my.cnf  ~/.my.cnf


# bajo todas las dependencias de bower y esas cosas para ditella
cd /media/data/Proyectos/ditella-scrapping-web
npm install
bower install


# --------------------------------------------------------------------
# Download pip packages

cd /media/data/Proyectos/entrenamiento-arqueria
virtualenv --no-site-packages ~/envs/entrenamiento
~/envs/entrenamiento/bin/pip install -e .

cd /media/data/Proyectos/ditella-scrapping-lotes-backend
virtualenv --no-site-packages ~/envs/lotes
~/envs/lotes/bin/pip install -e .

cd /media/data/Proyectos/agatha-backend
virtualenv --no-site-packages ~/envs/agatha
~/envs/lotes/bin/pip install -e .


# --------------------------------------------------------------------
# Other less common programs

sudo mkdir -p /opt/local
sudo chown tzulberti:tzulberti /opt/local

# Golang
cd /opt/local
wget "https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz"
tar -xzf go1.6.2.linux-amd64.tar.gz
rm -rf go1.6.2.linux-amd64.tar.gz


# Rustlang
curl -sSf https://static.rust-lang.org/rustup.sh | sh

# Maven
cd /opt/local
wget "http://apache.dattatec.com/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz"
tar -xzf apache-maven-3.3.9-bin.tar.gz
rm -rf apache-maven-3.3.9-bin.tar.gz

# Docker
sudo apt-get install -y linux-image-extra-$(uname -r)
sudo apt-get install -y docker-engine
sudo service docker start

# Eclipse (me baja el fucking installer en vez del IDE)
# cd /opt/local
# wget "http://eclipse.c3sl.ufpr.br/oomph/epp/neon/R/eclipse-inst-linux64.tar.gz"

# Download JDownloader (issues because it might require Mega to download the JAR)
# cd /opt/local

#  Latex y otras cosas que tardan
sudo apt-get install texlive-latex-base texlive-latex-extra texlive-latex-recommended
