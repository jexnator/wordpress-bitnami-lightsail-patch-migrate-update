# WSL Installation

## Windows (10/11)

1. **Open PowerShell as Administrator**:
   Press `Windows Key + X`, then select **Terminal (Administrator)** to open PowerShell with elevated privileges.

2. **Set WSL 2 as the Default Version**:
   In the PowerShell window, run the following command to ensure WSL 2 is the default version:

   ```powershell
   wsl --set-default-version 2
   ```

3. **Install WSL**:
   Install WSL and the default Linux distribution (Ubuntu) by running the following command in PowerShell:

   ```powershell
   wsl --install
   ```

4. **Restart Your Computer**:
   Save any unsaved work, then restart your computer using the following command:

   ```powershell
   shutdown -r -t 0
   ```

5. **After Restart - Open PowerShell as Administrator Again**:
   After the reboot, open PowerShell as Administrator once again (`Windows Key + X > Terminal (Administrator)`) and run the WSL install command again to set up Ubuntu:

   ```powershell
   wsl --install
   ```

6. **Set Up Your Linux Distribution**:
   After installation, you'll be prompted to set up your new Linux environment:

   - **Enter a UNIX username**: Define a username for your Linux environment (e.g., `ubuntu`).
   - **New password & Retype new password**: You will be prompted to enter and confirm a password.

7. **Verify the Installation**:
   Once set up, you will be connected to your Linux environment (evidenced by the green text `username@hostname`). You can verify that WSL is installed and functioning correctly by running:

   ```bash
   exit
   ```

   Then, in PowerShell:

   ```powershell
   wsl -l -verbose
   ```

   This command will display the installed Linux distributions and their versions.

---
