if test (id -u) -eq 0
  echo "don't run this script as root, it calls sudo"
  exit 1
end

set wg_fwmark 0xc738
set wg_table 1000
set wg_rule not from all fwmark $wg_fwmark lookup $wg_table

# jq expression to parse ip -j
set jq_expr \
"[
.[] |
.fwmark == \"$wg_fwmark\" and .src == \"all\" and .table == \"$wg_table\" and .not == null
] | any"

set connected_ipv4 (ip -4 -j rule list | jq $jq_expr)
set connected_ipv6 (ip -6 -j rule list | jq $jq_expr)

switch $argv[1]
  case up
    sudo resolvectl domain wg0 "~."
    if test $connected_ipv4 = "false"
      sudo ip -4 rule add $wg_rule
    end
    if test $connected_ipv6 = "false"
      sudo ip -6 rule add $wg_rule
    end
  case down
    sudo resolvectl domain wg0 ""
    if test $connected_ipv4 = "true"
      sudo ip -4 rule delete $wg_rule
    end
    if test $connected_ipv6 = "true"
      sudo ip -6 rule delete $wg_rule
    end
  case status
    if test $connected_ipv4 = $connected_ipv6
      if test $connected_ipv4 = "true"
        echo "vpn connected"
        exit 0
      else
        echo "vpn disconnected"
        exit 1
      end
    else
      if test $connected_ipv4 = "true"
        echo "connected only on ipv4"
      else
        echo "connected only on ipv6"
      end
      exit 1
    end
  case "*"
    echo "use 'up' or 'down' to activate/deactivate the wireguard vpn or 'status' to check"
end
