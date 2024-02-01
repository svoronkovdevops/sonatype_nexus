sudo apt-get update

sudo apt install openjdk-8-jre-headless -y

sudo apt install unzip

sudo wget https://services.gradle.org/distributions/gradle-7.5.1-bin.zip -P /tmp

sudo apt install git-all -y

sudo ufw disable

sudo swapoff -a

sudo apt-get update && sudo apt-get install -y apt-transport-https

cd /opt

sudo mkdir nexus

sudo wget https://download.sonatype.com/nexus/3/nexus-3.60.0-02-unix.tar.gz

sudo tar xf nexus-3.60.0-02-unix.tar.gz

cd nexus-3.60.0-02

cd bin

sudo ./nexus run

# restart if need
# cd /opt/nexus-3.60.0-02/bin 
# ./nexus run 
# ./nexus restart