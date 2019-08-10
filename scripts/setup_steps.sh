sudo yum install -y git-core
git clone https://github.com/jasonswett/mississippi_dot_com.git
cd mississippi_dot_com

sudo yum install docker -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo service docker start
sudo docker-compose up -d
sudo docker-compose run web rails db:create
