sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install python-software-properties
yes | sudo add-apt-repository ppa:saltstack/salt
sudo apt-get update

sudo apt-get -y install salt-master
sudo apt-get -y install salt-minion

sudo sed -i 's/#master:.*$/master: localhost/g' /etc/salt/minion
sudo service salt-minion restart

minion=`sudo salt-key -L | sed -n 3p | sed -e 's/\s.*$//'`

if [ "$minion" != "Unaccepted" ]; then
  yes | sudo salt-key -a $minion
fi

sudo salt '*' pkg.install mongodb

TRUE=`sudo salt '*' test.ping | sed -n 2p`

echo "install completed : $TRUE"
