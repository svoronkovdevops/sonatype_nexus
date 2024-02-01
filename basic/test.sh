sudo apt-get update

sudo apt install openjdk-11-jre-headless -y

sudo ssh-keygen -t rsa -f jenk

sudo cat jenk.pub >> /home/vagrant/.ssh/authorized_keys

sudo apt install docker.io -y

sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock

sudo apt install maven -y

sudo apt install unzip

sudo wget https://services.gradle.org/distributions/gradle-7.5.1-bin.zip -P /tmp

sudo unzip -d /opt/gradle /tmp/gradle-*.zip

sudo export PATH=$PATH:/opt/gradle/gradle-7.5.1/bin

sudo apt install git-all -y

sudo systemctl enable docker

sudo systemctl start  docker

sudo systemctl status docker

sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose


sudo ufw disable

sudo swapoff -a

sudo apt-get update && sudo apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo bash -c 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list'

sudo apt-get update && sudo apt-get install -y kubelet kubeadm kubectl

sudo systemctl enable kubelet

sudo systemctl start kubelet

touch report.txt

git --version >> report.txt

java --version >> report.txt

mvn --version >> report.txt

gradle -v >> report.txt

docker --version >> report.txt

kubectl version >> report.txt

docker-compose --version >> report.txt