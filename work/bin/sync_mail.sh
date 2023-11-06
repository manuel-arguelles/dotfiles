#!/bin/bash

if ! pgrep "mbsync" > /dev/null
then
  . ~/.gnupg/gpg-agent-info
  export GPG_AGENT_INFO
  mbsync -a
fi

