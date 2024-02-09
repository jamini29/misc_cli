# How To Find Public IP Address CLI

prefered with `dig`
```
# ipv4
dig +short myip.opendns.com @resolver1.opendns.com
dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
dig +short txt ch whoami.cloudflare @1.0.0.1
# ipv6
dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com

myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
```
not good but possible with `curl`
```
curl checkip.amazonaws.com
curl ifconfig.me
curl icanhazip.com
curl ipecho.net/plain
curl ifconfig.co

server_ip="$(curl ifconfig.co)"
```
