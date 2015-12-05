Mydocs
====================

##Proxmox/OpenVZ

##### sysctl

If you receive this message `sysctl: permission denied on key 'xxx.xxx.xxx'` in your openvz container. You cannot change the sysctl options in the openvz container, for that, you can set this options in the host hypervisor. 

```bash
# In the hypervisor
nano /etc/sysctl.conf
#xxx.xxx.xxx=somevalue
#
sysctl -p
```
##unbound

 * **Diagnose**
  * Debug the salt minion `salt-minion -l debug`
##unbound

 * **Diagnose**
  * Check the unbound configuration with `unbound-checkconf`

##collectd

 * **Diagnose**
  * Check collectd config `collectd -t`
  * Check collecd plugins `collectd -T`
  * Check collecd in foreground mode `collectd -f`

## Oh My Zsh

 * **Disable git status in prompt**
  * Some project have many files, and `Oh My Zsh` is slow for respond, For some project, you can disable git prompt feature. Go to your git project and type this command
   * `git config --add oh-my-zsh.hide-status 1`
