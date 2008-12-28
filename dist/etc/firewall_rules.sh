# flush all chains
iptables -F
# set the default policy for each of the pre-defined chains
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP
# to allow incoming traffic
iptables -A INPUT -p tcp -s 0/0 --dport 22 -j ACCEPT # ssh
iptables -A INPUT -p tcp -s 0/0 --dport 80 -j ACCEPT # http
iptables -A INPUT -p tcp -s 0/0 --sport 53 -d 0/0 -j ACCEPT # dns replies
iptables -A INPUT -p udp -s 0/0 --sport 53 -d 0/0 -j ACCEPT # dns replies
# drop everything else
iptables -A INPUT -i eth+ -p udp -j REJECT
iptables -A INPUT -i eth+ -p tcp -m tcp --syn -j REJECT
# accept anything on localhost
iptables -A INPUT -i lo -j ACCEPT
