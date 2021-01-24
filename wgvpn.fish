if test (id -u) = 0
  echo "don't run this script as root, it will call sudo"
  exit 1
end

switch $argv[1]
  case up
    if test ! -f /tmp/.wgvpn
      sudo ip rule add not from all fwmark 51000 lookup 1000
      touch /tmp/.wgvpn
    else
      echo "already up"
      exit 1
    end
  case down
    if test -f /tmp/.wgvpn
      sudo ip rule delete not from all fwmark 51000 lookup 1000
      rm /tmp/.wgvpn
    else
      echo "not up"
      exit 1
    end
  case '*'
    echo "use 'up' or 'down' to activate/deactivate the wireguard vpn"
end