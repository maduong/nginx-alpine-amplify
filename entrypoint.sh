#!/bin/sh

echo "Updating agent.conf...."
echo "API_KEY=${API_KEY}"
echo "AMPLIFY_IMAGENAME=${AMPLIFY_IMAGENAME}"

agent_conf_file="/etc/amplify-agent/agent.conf"
sed -i.old -e "s/api_key.*$/api_key = ${API_KEY}/" ${agent_conf_file}
sed -i.old -e "s/imagename.*$/imagename = ${AMPLIFY_IMAGENAME}/" ${agent_conf_file}

echo "Starting nginx...."
nginx -g "daemon off;" &
nginx_pid=$!

echo "Starting amplify...."
python /usr/bin/nginx-amplify-agent.py start --config=/etc/amplify-agent/agent.conf --pid=/var/run/amplify-agent/amplify-agent.pid

echo "Everything is OK now."
wait ${nginx_pid}
