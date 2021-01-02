# first import environment variables from the login manager
systemctl --user import-environment
# then start the service
systemctl --user start sway.service

# poll for sway
while test (count (pgrep sway)) -gt 1
  sleep 5
end

systemctl --user stop kanshi xdg-desktop-portal-wlr
