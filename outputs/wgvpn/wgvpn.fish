if test (id -u) -eq 0
  echo "don't run this script as root, it calls sudo"
  exit 1
end

set wg_fwmask 0xc738
set wg_table 1000
set wg_rule not from all fwmark $wg_fwmark lookup $wg_table

# jq expression to parse ip -j
set jq_expr \
"[
.[] |
.fwmask == \"$wg_fwmask\" and .fwmark == \"0\" and .src == \"all\" and .table == \"$wg_table\" and .not == null
] | any"

set connected_ipv4 (ip -4 -j rule list | jq $jq_expr)
set connected_ipv6 (ip -6 -j rule list | jq $jq_expr)

function check_status_ipv4
  set connected_ipv4 (ip -4 -j rule list | jq $jq_expr)
  if test $connected_ipv4 = "true"
    return 1
  else
    return 0
  end
end

function check_status_ipv6
  set connected_ipv6 (ip -6 -j rule list | jq $jq_expr)
  if test $connected_ipv6 = "true"
    return 1
  else
    return 0
  end
end

function check_status
  check_status_ipv4
  set connected_ipv4 $status
  check_status_ipv6
  set connected_ipv6 $status
  if test $connected_ipv4 = $connected_ipv6
    if test $connected_ipv4 = 1
      return 0
    else
      return 1
    end
  else
    if test $connected_ipv4 = 1
      return 3
    else
      return 4
    end
  end
end

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
    check_status
    set vpn_status $status
    switch $vpn_status
      case 0
        echo "vpn connected"
      case 1
        echo "vpn disconnected"
      case 2
        echo "vpn only connected on ipv4"
      case 3
        echo "vpn only connected on ipv6"
    end
  case bar
    check_status
    set vpn_status $status
    if test $status = 0
      echo '{"class": "connected", "text": "VPN "}'
    else
      echo '{"class": "disconnected", "text": "VPN "}'
    end
  case "*"
    echo "use 'up' or 'down' to activate/deactivate the wireguard vpn or 'status' to check"
end
