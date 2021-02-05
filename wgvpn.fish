function sudo
  if test (id -u) -eq 0
    $argv
  else
    command sudo $argv
  end
end


# jq expression to parse ip -j
set jq_expr '
[
.[] |
.fwmark == "0xc738" and .src == "all" and .table == "1000" and .not == null
] | any
'

set connected_ipv4 (ip -4 -j rule list | jq $jq_expr)
set connected_ipv6 (ip -6 -j rule list | jq $jq_expr)

switch $argv[1]
  case up
    if test $connected_ipv4 -eq "false"
      sudo ip rule add not from all fwmark 0xc738 lookup 1000
    end
    if test $connected_ipv6 -eq "false"
      sudo ip -6 rule add not from all fwmark 0xc738 lookup 1000
    end
  case down
    if test $connected_ipv4 -eq "true"
      sudo ip rule delete not from all fwmark 0xc738 lookup 1000
    end
    if test $connected_ipv4 -eq "true"
      sudo ip -6 rule delete not from all fwmark 0xc738 lookup 1000
    end
  case status
    echo "ipv4: $connected_ipv4, ipv6: $connected_ipv6"
  case '*'
    echo "use 'up' or 'down' to activate/deactivate the wireguard vpn or 'status ' to check"
end
