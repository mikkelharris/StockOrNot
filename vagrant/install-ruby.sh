 #!/usr/bin/env bash

 source /usr/local/rvm/scripts/rvm
 
 rvm use --install $1

 rvm rubygems current
 
 shift

 if (( $# ))
 then gem install $@
 fi