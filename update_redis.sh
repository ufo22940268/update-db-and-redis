#!/usr/bin/env bash
redis-cli keys "wuji:userDetail:Id:*" | grep -v "Rp:App" | xargs redis-cli del
