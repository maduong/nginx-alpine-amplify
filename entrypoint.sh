#!/bin/sh

agent_conf_file="/etc/amplify-agent/agent.conf"
sed -i.old -e "s/api_key.*$/api_key = ${API_KEY}/" ${agent_conf_file}
sed -i.old -e "s/imagename.*$/imagename = ${AMPLIFY_IMAGENAME}/" ${agent_conf_file}

nginx -g "daemon off;" &
nginx_pid=$!

python /usr/bin/nginx-amplify-agent.py start --config=/etc/amplify-agent/agent.conf --pid=/var/run/amplify-agent/amplify-agent.pid

wait ${nginx_pid}