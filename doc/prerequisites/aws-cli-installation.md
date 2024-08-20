# AWS CLI Installation

## MacOS

1. **Install Homebrew** (if not already installed):
   If you haven't installed Homebrew yet, run the following command in Terminal:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Update Homebrew**:

   ```bash
   brew update
   ```

3. **Install AWS CLI**:

   ```bash
   brew install awscli
   ```

4. **Verify the Installation**:
   ```bash
   aws --version
   ```

---

## Windows (11) via WSL

1. **Open PowerShell as Administrator**:
   Press `Windows Key + X`, then select **Terminal** to open PowerShell.

2. **Launch WSL**:
   In the PowerShell window, type:

   ```powershell
   wsl
   ```

3. **Install AWS CLI via Snap**:
   Once in the WSL terminal, run the following command to install AWS CLI (you may be prompted to enter your password):

   ```bash
   sudo snap install aws-cli --classic
   ```

4. **Refresh Snap Packages**:
   After installing AWS CLI, refresh all snap packages to ensure they are up to date:

   ```bash
   sudo snap refresh
   ```

5. **Verify the Installation**:
   After installation, verify that AWS CLI is correctly installed by running:

   ```bash
   aws --version
   ```

6. **Exit WSL**:
   Once the installation is complete, you can exit the WSL terminal by running:

   ```bash
   exit
   ```

---
