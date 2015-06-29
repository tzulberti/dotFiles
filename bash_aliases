export BOLD=`tput bold`                                                          
export UNDERLINE_ON=`tput smul`                                                  
export UNDERLINE_OFF=`tput rmul`                                                 
export TEXT_BLACK=`tput setaf 0`                                                 
export TEXT_RED=`tput setaf 1`                                                   
export TEXT_GREEN=`tput setaf 2`                                                 
export TEXT_YELLOW=`tput setaf 3`                                                
export TEXT_BLUE=`tput setaf 4`                                                  
export TEXT_MAGENTA=`tput setaf 5`                                               
export TEXT_CYAN=`tput setaf 6`                                                  
export TEXT_WHITE=`tput setaf 7`                                                 
export BACKGROUND_BLACK=`tput setab 0`                                           
export BACKGROUND_RED=`tput setab 1`                                             
export BACKGROUND_GREEN=`tput setab 2`                                           
export BACKGROUND_YELLOW=`tput setab 3`                                          
export BACKGROUND_BLUE=`tput setab 4`                                            
export BACKGROUND_MAGENTA=`tput setab 5`                                         
export BACKGROUND_CYAN=`tput setab 6`                                            
export BACKGROUND_WHITE=`tput setab 7`                                           
export RESET_FORMATTING=`tput sgr0`                                              
                                                                                 
                                                                                 
# Wrapper function for Maven's mvn command.                                      
mvn-color()                                                                      
{                                                                                
    # Filter mvn output using sed                                                
    mvn $@ | sed -e "s/\(\[INFO\]\ \-.*\)/${TEXT_BLUE}${BOLD}\1/g" \             
    -e "s/\(\[INFO\]\ \[.*\)/${RESET_FORMATTING}${BOLD}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[INFO\]\ BUILD SUCCESSFUL\)/${BOLD}${TEXT_GREEN}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[WARNING\].*\)/${BOLD}${TEXT_YELLOW}\1${RESET_FORMATTING}/g" \      
    -e "s/\(\[ERROR\]\ BUILD FAILURE\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[ERROR\].*\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}/g" \           
    -e "s/\(\ERROR\.*\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}/g" \             
    -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${BOLD}${TEXT_GREEN}Tests run: \1${RESET_FORMATTING}, Failures: ${BOLD}${TEXT_RED}\2${RESET_FORMATTING}, Errors: ${BOLD}${TEXT_RED}\3${RESET_FORMATTING}, Skipped: ${BOLD}${TEXT_YELLOW}\4${RESET_FORMATTING}/g"
                                                                                 
    # Make sure formatting is reset                                              
    echo -ne ${RESET_FORMATTING}                                                 
} 

alias mvnc="mvn-color" 
alias pyclean='find . -name "*.pyc" -exec rm -rf {} \;'

alias jdownloader="java -jar /opt/local/JDownloader/JDownloader.jar"
alias sublime="/opt/local/Sublime\ Text\ 2/sublime_text"
alias ages_2="cd /media/Juegos\ y\ ot/Juegos/Age\ of\ Empires\ II; wine age2_x1.exe"

# la rerenfencia a los proyectos de python
alias arqueria-active="source ~/envs/arqueria/bin/activate"
alias arqueria-cd="cd /media/data/Proyectos/archery-data/archery_data"
alias otendor-activate="source ~/envs/otendor-data/bin/activate"
alias otendor-cd="cd /media/data/Proyectos/otendor-data/otendor"

alias pypi-cd="cd /media/data/Proyectos/Flask-PyPi-Proxy/flask_pypi_proxy"
alias pypi-activate="source ~/envs/pypi/bin/activate"

alias entrenamiento-cd="cd /media/data/Proyectos/entrenamiento-arqueria/entrenamiento"
alias entrenamiento-activate="source ~/envs/entrenamiento/bin/activate"
# para que siempre use vim para todo lo que sea posible
export EDITOR=vim


# todo lo relacionado con el trabajo 
if [ -f ~/.bash_aliases_trabajo ]; then
    . ~/.bash_aliases_trabajo
fi


