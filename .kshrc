# @(#).kshrc 1.0

# Base Korn Shell environment

# Approach:

#      shell            initializations go in ~/.kshrc
#      user             initializations go in ~/.profile
#      host / all_user  initializations go in /etc/profile
#      hard / software  initializations go in /etc/environment      

# DEBUG=y       # uncomment to report

[ "$DEBUG" ] && echo "Entering .kshrc"
set -o allexport

#---------------------------------------------------------------
# options for all shells --------------------------------
#---------------------------------------------------------------
# LIBPATH must be here because ksh is setuid, and LIBPATH is
# cleared when setuid programs are started, due to security hole.

LIBPATH=.:/local/lib:/lib:/usr/lib




#---------------------------------------------------------------
# options for interactive shells follow-------------------------
#---------------------------------------------------------------
TTY=$(tty|cut -f3-4 -d/)
HISTFILE=$HOME/.sh_hist$(echo ${TTY} | tr -d '/')
PWD=$(pwd)
PS1='${LOGNAME}@${HOSTNAME} on ${TTY} [${PWD}] '

#---------------------------------------------------------------
# aliases
#---------------------------------------------------------------

#[ "$DEBUG" ] && echo "Setting aliases"

alias man="/afs/austin/local/bin/man -e less"
alias pg="pg -n -p':Page %d: '"
alias more="pg -n -p':Page %d: '"
alias cls="tput clear"
alias sane="stty sane"
alias rsz='eval $(resize)'

#---------------------------------------------------------------
# mail check
#---------------------------------------------------------------
#if [ -s "$MAIL" ]       # This is at Shell startup.  In 
#then echo"$MAILMSG"     # normal operation, the Shell checks
#fi                      # periodically.

#---------------------------------------------------------------
# aixterm window title
#---------------------------------------------------------------

#[[ "$TERM" = "aixterm" ]] && echo 
#"\033]0;$USER@${HOSTNAME%t1}\007"

#---------------------------------------------------------------
# functions
#---------------------------------------------------------------
[ "$DEBUG" ] && echo "Setting functions"

function pid { ps -e | grep $@ | cut -d" " -f1; }

function df {
  /bin/df $* | grep -v afs;
  echo "\nAFS:";
  /usr/afs/bin/fs listquota /afs;
}

function term {
  if [ $# -eq 1 ]
  then
    echo $TERM
    TERM=$1
    export TERM
  fi
  echo $TERM
}

function back {

  cd $OLDPWD
  echo $CWD $OLDPWD
}

[ "$DEBUG" ] && echo "Exiting .kshrc"

set +o allexport



#-------------------------------------------
# NS settings
#-------------------------------------------

    #-------------------------------------------
    # version 2-32
    #-------------------------------------------
    
        # LD_LIBRARY_PATH
        OTCL_LIB=/usr/share/ns-allinone-2.32/otcl-1.13
        NS2_LIB=/usr/share/ns-allinone-2.32/lib
        X11_LIB=/usr/X11R6/lib
        USR_LOCAL_LIB=/usr/local/lib
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$OTCL_LIB:$NS2_LIB:$X11_LIB:$USR_LOCAL_LIB  

        # TCL_LIBRARY
        TCL_LIB=/usr/share/ns-allinone-2.32/tcl8.4.15/library
        USR_LIB=/usr/lib
        export TCL_LIBRARY=$TCL_LIB:$USR_LIB  

        # PATH
        #XGRAPH=/usr/share/ns-allinone-2.32/bin:/usr/share/ns-allinone-2.32/tcl8.4.15/unix:/usr/share/ns-allinone-2.32/tk8.4.14/unix
        XGRAPH=/usr/share/ns-allinone-2.32/bin:/usr/share/ns-allinone-2.32/tcl8.4.15/unix:
        NS=/usr/share/ns-allinone-2.32/ns-2.32/
        NAM=/usr/share/ns-allinone-2.32/nam-1.13/
        PATH=$PATH:$XGRAPH:$NS:$NAM   
