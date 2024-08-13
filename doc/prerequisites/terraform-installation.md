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

## Windows (11)

1. **Install Chocolatey** (if not already installed):
   Open PowerShell with Administrator rights and run the following command:

   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```

2. **Install Terraform**:
   Open PowerShell with Administrator rights and run the following command:

   ```powershell
   choco install terraform
   ```

3. **Verify the Installation**:
   ```powershell
   terraform --version
   ```

---
