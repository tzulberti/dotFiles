# If there is some kind of error stop
set -e
set -u

LOG_FILE='/tmp/local_setup.log'

function add_dependencies_for_external_repos() {
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates wget ca-certificates curl curl
  sudo install -m 0755 -d /etc/apt/keyrings
}

function add_chrome_external_repo() {
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
  sudo apt-get update
}

function add_docker_external_repo() {
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
}

function enable_snap() {
  sudo rm /etc/apt/preferences.d/nosnap.pref
  sudo apt update
  sudo apt install snapd
}

function install_packages() {
  sudo apt-get install -y htop vim exuberant-ctags unzip unrar curl vim-nox
  sudo apt-get install -y mplayer easytag mpv mediainfo
  sudo apt-get install -y google-chrome-stable
}

function install_development_tools() {
  sudo apt-get install -y git mercurial subversion
  sudo apt-get install -y build-essential python3-pip python3-virtualenv
  sudo apt-get install -y postgresql libpq-dev
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  curl https://mise.run | sh
}

function install_snap_packages() {
  sudo snap install code --classic
  sudo snap install postman
}

function configure_vim() {
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}


function instal_heroic() {
  flatpak install flathub com.heroicgameslauncher.hgl
  flatpak run com.heroicgameslauncher.hgl
}



function install_mise_languages() {
  mise install java
  mise install java17
  mise install rust
  mise install go
  mise install python
}

function clone_repos() {
  mkdir -p $HOME/Projects
  my_repos=(
    "https://github.com/tzulberti/dotFiles.git"
    "https://github.com/PyAr/wiki.git"
    "https://github.com/PyAr/pyarweb.git"
  )

  cd $HOME/Projects
  for repo in ${my_repos}; do
    git clone $repo
  end
}

function configuration_files() {
  mkdir -p ~/.config/gtk-3.0/
  mkdir -p ~/.config/nvim/
  cd $HOME/Projects

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
  ln -sf $(pwd)/psqlrc  ~/.psqlrc
  ln -sf $(pwd)/nvimrc ~/.config/nvim/init.vim
}


function print_output() {
  echo "$(date) $1" | tee -a $LOG_FILE
}

function main() {
  functions_to_execute=(
    "add_dependencies_for_external_repos"
    "add_chrome_external_repo"
    "add_docker_external_repo"
    "enable_snap"
    "install_packages"
    "install_development_tools"
    "install_snap_packages"
    "configure_vim"
    "instal_heroic"
    "install_mise_languages"
    "clone_repos"
    "configuration_files"
  )
  for func_name in ${functions_to_execute}; do
    if grep -q "Finished $func_name" $LOG_FILE ; then
      print_output "Skipping $func_name because it is already done"
    else
      print_output "Starting $func_name"
      eval $func_name
      print_output "Finished $func_name"
    end 
  end
}


main