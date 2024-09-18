# Linux Command

## Firewall


### ufw (Uncomplicated Firewall)
```bash

# Allow traffic on port 8000  
sudo ufw allow 8000
sudo ufw delete allow 8000

# Deny Access to a Specific port
sudo ufw deny 8000
sudo ufw delete deny 8000


# Restrict Access to Specific IP Addresses:
# If you want to restrict access to a specific IP address or subnet for added security, you can specify the source IP:
sudo ufw allow from 192.168.1.100 to any port 5000


sudo ufw status numbered
sudo ufw show added                             
```

### firewall-cmd

```bash
# If you are using firewalld, you can open the port with:
sudo firewall-cmd --add-port=5000/tcp --permanent
sudo firewall-cmd --reload

```





