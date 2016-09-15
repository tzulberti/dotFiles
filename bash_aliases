
alias ages_2="cd /media/data/Juegos/Age\ of\ Empires\ II; wine age2_x1.exe"

# la rerenfencia a los proyectos de python
alias pyclean='find . -name "*.pyc" -exec rm -rf {} \; && find . -name "*.so" -exec rm -rf {} \; && find . -name "*.c" -exec rm -rf {} \; && find . -name "*.pyo" -exec rm -rf {} \;'

alias entrenamiento-cd="cd /media/data/Proyectos/entrenamiento-arqueria/entrenamiento"
alias entrenamiento-activate="source ~/envs/entrenamiento/bin/activate"

alias agatha-cd="cd /media/data/Proyectos/agatha-backend/"
alias agatha-activate="source ~/envs/agatha/bin/activate"

export ENTRENAMIENTO_CONFIGURATION='/home/tzulberti/.entrenamiento-configuration.py'


# para que siempre use vim para todo lo que sea posible
export EDITOR=vim


# el config para varias de las cosas que instalo en /opt/local
export GOROOT=/opt/local/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:/opt/local/apache-maven-3.3.9/bin

# variables para simplificarme la vida
export WORKSPACE=/meda/data/Proyectos


# todo lo relacionado con el trabajo 
if [ -f ~/.bash_aliases_trabajo ]; then
    . ~/.bash_aliases_trabajo
fi


