#!/bin/csh
# @(#)cshrc

#********************************************************************************
# Executed each time a new cshell is started - this is run first, before .login
# This should contain shell variables like cdpath and prompt, and aliases. 
# These things are not passed to subshells through the environment so they 
# need to be set each time in .cshrc.
#********************************************************************************

# If this is an interactive shell
if ( $?prompt ) then
    echo -e "\n...loading cshrc ...\n\n"
endif

setenv MY_LOCAL_VIEW_PATH
setenv VOBSINV /vobs/inventory_mgr

if ( `hostname` == juneau ) then
   echo stupid junueau or stupid tarentella....
else if ( `hostname` == solaris8) then
   echo stupid junueau or stupid tarentella....
	alias jack rlogin jack
	alias guinness rlogin guinness
else
#    as soon as we log in, I want to get rid of that crap..

   if(! -d ${MY_LOCAL_VIEW_PATH}/unix) then
#      echo "'1' for main view (snapshot)"
#      echo "'3' for 3.0  view (snapshot)"

      set VIEW_CHOICE = '1'   ######  $<
# set VIEW_CHOICE =  $<
      if( ${VIEW_CHOICE} == '1') then
         setenv AP_MY_VIEW 
         setenv AP_VERSION main
         setenv VOBSINV
         setenv MY_LOCAL_VIEW_PATH /project/atsesvn/sg216005/trunk
      else if (${VIEW_CHOICE} == '3') then
         setenv MY_LOCAL_VIEW_PATH ~/snap30/
         setenv AP_MY_INSTANCE po
         setenv AP_VERSION im3.0
      endif
   endif
endif
#********************************************************************************
# Set some shell variables
#********************************************************************************
umask 007                               # rwxrwx---

#*********************************************************************************
# Look for where uname is
# On most machines in /bin; sun in /usr/5bin
#*********************************************************************************
uname >& /dev/null

#f (  $status ) then
    if (  -x /usr/5bin/uname ) then
         alias uname /usr/5bin/uname
    else if (  -x /bin/uname ) then
         alias uname /bin/uname
    else if (  -x /usr/bin/uname ) then
         alias uname /usr/bin/uname
    else
        echo "Could not find uname in path , /bin or /usr/5bin"
    endif
#ndif

#*********************************************************************************
# idem for whoami          
#*********************************************************************************
if (  -x /usr/bin/whoami ) then
    alias whoami /usr/bin/whoami
else if (  -x /usr/ucb/whoami) then
    alias whoami /usr/ucb/whoami
else
    echo Could not find WHOAMI in path
endif


#********************************************************************************
# If this is an interactive shell
#********************************************************************************

if ( $?prompt ) then
    # Set file completion, ignoring the '*.o' files
    set filec on
    set fignore='.o'

    set history=499
    set savehist=499
    set notify
    set filec

    # Set tty stuff
    # Set erase character to Ctrl-H, set kill character to Ctrl-U,
    # set interrupt character to Ctrl-C
    # stty werase '^?' 
    #stty erase '^?'
    stty erase '^H'
#   stty kill '^U' rprnt '^R' echoe
    stty intr '^C' 

    #set cdpath=( ~ ~/links)		# Set cd path (paths to try when cd'ing)
    #set mail=(15 /usr/mail/`whoami`)# Set mail ??
    set lineedit

    source ~/.BlouAlias
    set prompt = "%T [\!\][%{\033[34m%}`whoami`@`hostname`%{\033[0m%}: `pwd`]>"
endif


# Now, the clearcase view doesn't start .login so here it is.
#if( -d ${MY_LOCAL_VIEW_PATH}${VOBSINV}/unix) then
#    echo Sourcing the .login
#    source ~/.login 
#endif
if ($?BITS) then
   set prompt = "`whoami`@`hostname`_${BITS}[\\!]`pwd`>"
endif


#}}}#---------------------------------------------------------------------------
#    aliases
#---------------------------------------------------------------------------#{{{
#alias grep 'grep --color'
alias cd 'cd \!\!*;set prompt = "%T [\!\][%{\033[34m%}`whoami`@`hostname`%{\033[0m%}: `pwd`]>"'
alias vim /opt/vim/bin/vim
alias reload 'source ~/.cshrc'
alias rmf 'rm -rf'
alias la 'ls -la'

alias svnco svn co http://svn.dev.sabre.com/svn/inventory_manager/inventory_manager/trunk


#-------------------------------------------------------------------------------
# settings
#-------------------------------------------------------------------------------
set TERM=vt100
set editmode = vi
set history = 20              # set history buffer size

bindkey ^R/ i-search-back
   

#-------------------------------------------------------------------------------
if ( $?prompt ) then
   echo '...ending .cshrc'
endif
