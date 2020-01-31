# Harvest
Make it easy to harvest eggs in the game  *hens lay eggs*.

# Usage
Clone this repo, then set a crontab job to execute it automatically.  

First, execute the following commands.
```bash=
git clone https://github.com/liuwilliamBUPT/Harvest
cd Harvest
chmod +x autoHarvest.sh
crontab -e
```
Then, set your corntab.
For example:
```bash=
0 */4 * * * bash ~/path/to/Harvest/autoHarvest.sh
```

Last, copy your cookies using *Export cookies.txt* Chrome plugin, and paste in cookies.txt.

If necessary, you can execute these commands to add your ServerChan SCEKEY or your [qqbot](https://github.com/cqmoe/python-cqhttp) setting to inform you that your cookies have been expired.
```bash=
vim config

secret_key=your_serverchan_secret_key
qqbot_host=host:port
token=your_qqbot_token
qq=your_qq_id
```


Please note that only when the crontab interval is a factor of 12 can the newest feature that automatically checks in at midnight work. 
