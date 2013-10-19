 #!/usr/bin/env bash

 source /usr/local/rvm/scripts/rvm

 export LANGUAGE=en_US.UTF-8
 export LANG=en_US.UTF-8
 export LC_ALL=en_US.UTF-8
 
 rvm use --install $1

 rvm rubygems current
 
 shift

 if (( $# ))
 then gem install $@
 fi