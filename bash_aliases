alias pyclean='find . -name "*.pyc" -exec rm -rf {} \; && find . -name "*.so" -exec rm -rf {} \; && find . -name "*.c" -exec rm -rf {} \;'

alias ages_2="cd /media/data/Juegos/Age\ of\ Empires\ II; wine age2_x1.exe"

# la rerenfencia a los proyectos de python
alias arqueria-active="source ~/envs/arqueria/bin/activate"
alias arqueria-cd="cd /media/data/Proyectos/archery-data/archery_data"
alias otendor-activate="source ~/envs/otendor-data/bin/activate"
alias otendor-cd="cd /media/data/Proyectos/otendor-data/otendor"

alias pypi-cd="cd /media/data/Proyectos/Flask-PyPi-Proxy/flask_pypi_proxy"
alias pypi-activate="source ~/envs/pypi/bin/activate"

alias entrenamiento-cd="cd /media/data/Proyectos/entrenamiento-arqueria/entrenamiento"
alias entrenamiento-activate="source ~/envs/entrenamiento/bin/activate"

alias agatha-cd="cd /media/data/Proyectos/agatha-backend/"
alias agatha-activate="source ~/envs/agatha/bin/activate"

export ENTRENAMIENTO_CONFIGURATION='/home/tzulberti/.entrenamiento-configuration.py'
# para que siempre use vim para todo lo que sea posible
export EDITOR=vim


# todo lo relacionado con el trabajo 
if [ -f ~/.bash_aliases_trabajo ]; then
    . ~/.bash_aliases_trabajo
fi


