if test (id -u) = 0
  echo "don't run this script as root, it will call sudo"
  exit 1
end

ip rule list | rg "lookup 1000"
set IsConnected $status

switch $argv[1]
  case up
    if test $IsConnected -eq 1
      sudo ip rule add not from all fwmark 51000 lookup 1000
      sudo ip -6 rule add not from all fwmark 51000 lookup 1000
    else
      echo "already up"
      exit 1
    end
  case down
    if test $IsConnected -eq 0
      sudo ip rule delete not from all fwmark 51000 lookup 1000
      sudo ip -6 rule delete not from all fwmark 51000 lookup 1000
    else
      echo "not up"
      exit 1
    end
  case '*'
    echo "use 'up' or 'down' to activate/deactivate the wireguard vpn"
end
