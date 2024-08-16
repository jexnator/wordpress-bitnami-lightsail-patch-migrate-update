# SSH Agent Forwarding

SSH Agent Forwarding allows you to use your local SSH keys to authenticate on a remote server, providing secure access without copying private keys to the server.

## MacOS

1. **Start the SSH Agent**:

   - Open Terminal and start the SSH agent if it’s not already running:

   ```bash
   eval "$(ssh-agent -s)"
   ```

2. **Add Your Private Key(s) to the SSH Agent**:
   - Add the private key(s) for both the old and new WordPress Bitnami instances to the SSH agent with the following commands:
   ```bash
   ssh-add /path/to/old-instance-private-key.pem
   ssh-add /path/to/new-instance-private-key.pem
   ```

---

## Windows (11)

1. **Install OpenSSH Beta via winget**:

   - Open **PowerShell** with administrative privileges and install OpenSSH Beta using winget. Note: Update to OpenSSH Beta mandatory, because the SSH agent forwarding with older or the pre-installed version of OpenSSH on Windows does not work correctly when forwarding to Linux instances!:

   ```powershell
   winget install "openssh beta" --accept-package-agreements --accept-source-agreements
   ```

2. **Enable and Start the SSH Agent**:

   - Set the SSH agent to start automatically:

   ```powershell
   Get-Service ssh-agent | Set-Service -StartupType Automatic
   ```

   - Then, start the SSH agent:

   ```powershell
   Start-Service ssh-agent
   ```

3. **Add Your Private Key(s) to the SSH Agent**:
   - Add the private key(s) for both the old and new WordPress Bitnami instances to the SSH agent using the following commands:
   ```powershell
   ssh-add C:\path\to\old-instance-private-key.pem
   ssh-add C:\path\to\new-instance-private-key.pem
   ```

---
