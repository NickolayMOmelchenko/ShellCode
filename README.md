# ShellCode

### Shell Generator Resources(Reverse, Bind, HoaxShell, MSFVenom)
[Shell Generator](https://www.revshells.com)

### Browser Extensions
[Hack-Tools Chrome Extension](https://chromewebstore.google.com/detail/hack-tools/cmbndhnoonmghfofefkcccljbkdpamhi)

### Spin Up a local Web Server on Linux
To set up a web server and host your script, follow these steps:

Create a PowerShell script:
   ```bash
   touch powershellreverse.ps1
   echo "<ShellCode here>" > powershellreverse.ps1
   wget https://github.com/NickolayMOmelchenko/ShellCode/raw/refs/heads/main/setup_windows_website.sh
   chmod +x setup_windows_website.sh
   sudo ./setup_windows_website.sh

