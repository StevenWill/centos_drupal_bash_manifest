#!/usr/bin/env bash

#######################################
# Manifest to set up CentOS for Drupal#
# Install MySQL, PHP, Ruby & Git ######
# Also install drush from pear ########
#######################################

yum install -y vim
yum install -y apache2 \
  mysql-server \
  php \
  php-cli \
  php-mysql \
  php-mbstring \
  php-gd \
  php-pear \
  php-xml \
  ruby \
  git \
  ruby

gem update system
gem install compass

service iptables stop
service httpd start
chkconfig iptables off

pear channel-discover pear.drush.org
pear install drush/drush

wget -qO- -O tmp.tgz http://download.pear.php.net/package/Console_Table-1.1.3.tgz && tar -xvzf tmp.tgz
mv Console_Table-1.1.3 /usr/share/pear/drush/lib/.
rm tmp.tgz

rm -rf /var/www/html
ln -fs /vagrant/drupal7 /var/www/html
