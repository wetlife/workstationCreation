# setup wifi from the command-line

1. determine interface-name:
```bash
iwconfig
```

2. scan for networks:
```bash
sudo iwlist <ifname> scan
```

3. connect to a network:
```bash
sudo iwconfig <ifname> essid <essid>
```
