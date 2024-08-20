# Terraform Installation

## MacOS

1. **Install Homebrew** (if not already installed):
   Open a Terminal and run the following command:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Update Homebrew**:

   ```bash
   brew update
   ```

3. **Install Terraform**:

   ```bash
   brew tap hashicorp/tap
   brew install hashicorp/tap/terraform
   ```

4. **Verify the Installation**:
   ```bash
   terraform --version
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

3. **Install Terraform via Snap**:
   Once in the WSL terminal, run the following command to install Terraform (you may be prompted to enter your password):

   ```bash
   sudo snap install terraform --classic
   ```

4. **Refresh Snap Packages**:
   After installing Terraform, refresh all snap packages to ensure they are up to date:

   ```bash
   sudo snap refresh
   ```

5. **Verify the Installation**:
   After installation, verify that Terraform is correctly installed by running:

   ```bash
   terraform --version
   ```

6. **Exit WSL**:
   Once the installation is complete, you can exit the WSL terminal by running:

   ```bash
   exit
   ```

---
