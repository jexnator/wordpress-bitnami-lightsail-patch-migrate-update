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

## Windows (11)

1. **Install Chocolatey** (if not already installed):
   Open PowerShell with Administrator rights and run the following command:

   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```

2. **Install AWS CLI**:
   Open PowerShell with Administrator rights and run the following command:

   ```powershell
   choco install awscli -y
   ```

3. **Verify the Installation**:
   ```powershell
   aws --version
   ```

---
