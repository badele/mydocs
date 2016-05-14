# System

## Process

Change process limitation without restart

```bash
prlimit --pid 23403 --nofile=2048:2048`
```


## Route

Clear route cache
```bash
ip route flush cache
```

List chache ofr destination

```bash
ip route list cache match 10.19.2.70

10.19.2.70 from 10.75.16.146 dev eth0 
    cache 
10.19.2.70 dev eth0  src 10.75.16.146 
    cache <redirected> 
```

Show route use for destination

```bash
ip route get 8.8.8.8

8.8.8.8 via 10.75.16.2 dev eth0  src 10.75.16.146 
    cache 
```

## Disk

### Resize partition and filesystem

```bash
fdisk /dev/xxx
p
d
n
w

#reboot 
resize2fs /dev/xxx
```


## SSH

Show ssh fingerprint

```bash
ssh-keygen -l -E md5 -f ~/.ssh/id_dsa.pub
```

## pptp

### Create pptp account

```bash
pptpsetup --create profilename --server pptp_server_hostname --username username --password PASSWORD --encrypt
```

### Connect or Disconnect to pptp server


```bash
pon profilename
poff profilename
```

### Route

For automatically add route when ppp interface is up, you can add the script into this folder `/etc/ppp/ip-up.d/route-to-ppp.sh`

```bash
#!/bin/bash

IFACE="ppp0"

NET=$(ifconfig $IFACE | egrep -o "inet [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | cut -d" " -f2 | cut -d"." -f1-3).0
route add -net ${NET} dev ${IFACE}
```







## Proxmox / OpenVZ

### Rsync

No change owner file permision on remote

```bash
rsync -avr --no-o xxxx
```


### tcpdump

Show detailed packet information

```bash
tcpdump -i etho  -vv -s 1600
tcpdump -vni eth0 -XX -s 0
```


Howto detect the close session cycle

Terminal-1
```bash
tcpdump -ni eth0 "tcp[tcpflags] & (tcp-fin) != 0" -w /tmp/tcpdump
```

Terminal-2
```bash
netstat -an | grep CLOSE | sort > /tmp/diff1
sleep 60
netstat -an | grep CLOSE | sort > /tmp/diff2
diff /tmp/diff1 /tmp/diff2
tcpdump  "tcp[tcpflags] & (tcp-fin) != 0" -r /tmp/tcpdump
```
### Swap

For free swap

```bash
swapoff -a
swapon -a
```

### sysdig

```bash
sysdig -cl # list-chisels
sysdig -w dumpfile.scap # Write dump
sysdig -r dumpfile.scap # Read dump

csysdig -r dumpfile.scap # Ncurse GUI & Read dump
```

### sysctl

If you receive this message `sysctl: permission denied on key 'xxx.xxx.xxx'` in your openvz container. You cannot change the sysctl options in the openvz container, for that, you can set this options in the host hypervisor. 

```bash
# In the hypervisor
nano /etc/sysctl.conf
#xxx.xxx.xxx=somevalue
#
sysctl -p
```

## Salt

### salt-master command

```bash
# Set state on all computers
salt '*' state.highstate

# Set specific state 
salt '*' state.apply your_statename,your_statename1

# Show the top state result
salt '*' state.show_top

# Show minion version
salt '*' test.version

# Mass minion update
salt '*' cmd.run "curl -L https://bootstrap.saltstack.com | sh -s -- -PA masterip stable 2015.8"

# Update master
curl -L https://bootstrap.saltstack.com | sh -s -- -P -M stable 2015.8
curl -L https://bootstrap.saltstack.com | sh -s -- -P -M git v2015.8.8

# Show mass minion state
salt-run manage.status

```

# Show

 * **Diagnose**
  * Debug the salt minion `salt-minion -l debug`

## Unbound

 * **Diagnose**
  * Check the unbound configuration with `unbound-checkconf`

## Collectd

 * **Diagnose**
  * Check collectd config `collectd -t`
  * Check collecd plugins `collectd -T`
  * Check collecd in foreground mode `collectd -f`

## Oh My Zsh

 * **Disable git status in prompt**
  * Some project have many files, and `Oh My Zsh` is slow for respond, For some project, you can disable git prompt feature. Go to your git project and type this command
   * `git config --add oh-my-zsh.hide-status 1`

## urxvt

 * **Know the font and current character**
  * CRTL + SHIFT & mouse click   
