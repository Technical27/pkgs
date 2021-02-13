# first import environment variables from the login manager
systemctl --user import-environment
# then start the service
systemctl --user start sway.service

while true
  sleep 864000000000
end
