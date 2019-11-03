# Harvest
Make it easy to harvest eggs in the game  *hens lay eggs*.

# Usage
Clone this repo, then set a crontab job to execute it automatically.  

First, excute the following command.
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
