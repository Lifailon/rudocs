mkdir -p jenkins_home && sudo chown -R 1000:1000 jenkins_home
mkdir -p jenkins_agent && sudo chown -R 1000:1000 jenkins_agent
docker-compose up -d --remove-orphans --force-recreate