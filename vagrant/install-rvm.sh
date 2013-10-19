 #!/usr/bin/env bash

sudo apt-get -y update

sudo apt-get -y install curl

curl -L https://get.rvm.io | bash -s stable --ruby
