# SSH Agent Forwarding

SSH Agent Forwarding allows you to use your local SSH keys to authenticate on a remote server, providing secure access without copying private keys to the server. With the steps below we ensure, that the SSH Agent is up and running.

## MacOS

1. **Start the SSH Agent**:

   - Open Terminal and start the SSH agent if it’s not already running:

   ```bash
   eval "$(ssh-agent -s)"
   ```

---

## Windows (11) via WSL

1. **Open PowerShell as Administrator**:

   - Press `Windows Key + X`, then select **Terminal** to open PowerShell.

2. **Access WSL**:

   - In the PowerShell terminal, start WSL:

   ```powershell
   wsl
   ```

3. **Start the SSH Agent**:

   - Inside the WSL terminal and start the SSH agent if it’s not already running:

   ```bash
   eval "$(ssh-agent -s)"
   ```

4. **Exit WSL**:

   - After setting up the SSH agent, exit WSL:

   ```bash
   exit
   ```

---
