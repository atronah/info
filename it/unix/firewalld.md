# Firewalld

[info source](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos-7)

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [see active zones](#see-active-zones)
- [see all rules for all zones](#see-all-rules-for-all-zones)
- [set default zone](#set-default-zone)
- [get services](#get-services)
- [list rules of zone](#list-rules-of-zone)
- [Open port by firewall-cmd](#open-port-by-firewall-cmd)
- [add GRE protocol to firewalld rules to use pppd](#add-gre-protocol-to-firewalld-rules-to-use-pppd)

<!-- /MarkdownTOC -->

### see active zones

```
firewall-cmd --get-active-zones
```


### see all rules for all zones

```
firewall-cmd --list-all-zones
```


### set default zone

```
firewall-cmd --set-default-zone=home
```


### get services

```
firewall-cmd --get-services
```


### list rules of zone

```
firewall-cmd --zone=home --list-all
```


### Open port by firewall-cmd

```
firewall-cmd --zone=FedoraServer --permanent --add-port=3050/tcp
firewall-cmd --reload
firewall-cmd --info-zone=FedoraServer
```


### add GRE protocol to firewalld rules to use pppd

```
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p gre -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv6 filter INPUT 0 -p gre -j ACCEPT
firewall-cmd --reload
```