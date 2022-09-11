{ pkgs, config, ... }:

let
  wan = "enp6s0";
  physLan = "enp5s0";
  lan = "lan0";
in
{
  imports = [
    ../modules
    ../hardware/whale.nix
    ../mounts/whale.nix
  ];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv4.conf.default.forwarding" = true;

    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv6.conf.default.accept_ra" = 0;

    "net.ipv6.conf.all.forwarding" = true;
    "net.ipv6.conf.default.forwarding" = true;
  };

  services.dhcpd4 = {
    enable = true;
    interfaces = [ "${lan}" ];
    extraConfig = ''
      option domain-name-servers 8.8.8.8, 1.1.1.1;
      option subnet-mask 255.255.255.0;
      subnet 192.168.3.0 netmask 255.255.255.0 {
        option broadcast-address 192.168.3.255;
        option routers 192.168.3.1;
        interface ${lan};
        range 192.168.3.100 192.168.3.199;
      }
    '';
  };

  networking = {
    hostName = "whale";

    nebula-averyan.enable = true;
    nebula-frsqr.enable = true;

    firewall.enable = false;
    nftables = {
      enable = true;
      ruleset = ''
        table inet filter {
          chain output {
            type filter hook output priority 100;
            accept
          }

          chain input {
            type filter hook input priority 0;

            ct state invalid counter drop comment "drop invalid packets"
            ct state { established, related } counter accept comment "accept traffic originated from us"

            iifname lo counter accept comment "accept any localhost traffic"
            tcp dport 22 counter accept comment "ssh"

            ip6 nexthdr icmpv6 icmpv6 type {
              destination-unreachable,
              packet-too-big,
              time-exceeded,
              parameter-problem,
              nd-router-advert,
              nd-neighbor-solicit,
              nd-neighbor-advert
            } counter accept comment "icmpv6"
            ip protocol icmp icmp type {
              destination-unreachable,
              router-advertisement,
              time-exceeded,
              parameter-problem
            } counter accept comment "icmpv4"

            ip6 nexthdr icmpv6 icmpv6 type echo-request counter accept comment "pingv6"
            ip protocol icmp icmp type echo-request counter accept comment "pingv4"

            counter drop
          }

          chain forward {
            type filter hook forward priority 0;

            iifname "${lan}" oifname "${wan}" counter accept comment "allow LAN to WAN"
            iifname "${wan}" oifname "${lan}" ct state { established, related } counter accept comment "allow established back to LAN"

            # ct status dnat counter accept comment "allow dnat forwarding"
            counter drop
          }
        }

        table ip nat {
          chain prerouting {
            type nat hook prerouting priority dstnat; policy accept;
          }

          chain postrouting {
            type nat hook postrouting priority srcnat; policy accept;
            oifname "${wan}" masquerade
          }
        }
      '';
    };

    bridges.${lan}.interfaces = [ "${physLan}" ];

    interfaces = {
      "${lan}" = {
        ipv4 = {
          addresses = [{
            address = "192.168.3.1";
            prefixLength = 24;
          }];
        };
      };
      "${wan}".useDHCP = true;
    };
  };
}
