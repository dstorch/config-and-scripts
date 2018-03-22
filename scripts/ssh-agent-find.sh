#! /bin/bash

AGENTPID=$HOME/.ssh/agent.pid
AUTHSOCK=$HOME/.ssh/auth.sock

if [[ -z ${SSH_AUTH_SOCK+x} ]]
then
	if [[ ! -e $AUTHSOCK || ! -e $(cat $AUTHSOCK) ]]
	then
		eval $(ssh-agent -s)
		echo $SSH_AUTH_SOCK> $AUTHSOCK
		echo $SSH_AGENT_PID> $AGENTPID
		echo 'New ssh-agent started. Run `ssh-add'\'' to cache your key.'
	else
		export SSH_AUTH_SOCK=$(cat $AUTHSOCK)
		export SSH_AGENT_PID=$(cat $AGENTPID)
	fi
fi
