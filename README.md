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

  * if Unbound not start, check the config with `unbound-checkconf`
