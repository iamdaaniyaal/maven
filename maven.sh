sudo yum install -y java-1.8.0-openjdk-devel
cd /usr/local/src
sudo yum install -y maven
cd /etc/profile.d/
sudo touch maven1.sh
sudo chmod 777 maven1.sh
sudo cat > maven1.sh << EOF
export M2_HOME=/usr/share/maven
export PATH=${M2_HOME}/bin:${PATH}
EOF
source /etc/profile.d/maven1.sh
