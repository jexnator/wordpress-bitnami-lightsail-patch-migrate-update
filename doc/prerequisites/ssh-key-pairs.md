# SSH Key Pairs

## Create New Lightsail Key Pair

Follow these steps to create a new SSH key pair for your new WordPress Bitnami Lightsail instance (It is also possible to use the same key pair as the old instance, but this is not recommended):

![Create New Lightsail Key Pair GIF](/doc/img/create-lightsail-key-pair.gif)

1. **Access AWS Lightsail**:

   - Log in to the [AWS Management Console](https://aws.amazon.com/console/).
   - Open the **Lightsail** service.

2. **Navigate to SSH Key Management**:

   - In the top-right corner of the Lightsail dashboard, click on your **Account** icon.
   - From the dropdown, select **Account**.

3. **Go to the SSH Keys Tab**:

   - In the **Account** settings, navigate to the **SSH keys** tab.

4. **Create a Custom Key Pair**:

   - In the **Custom keys** section, click on **Create key pair**.

5. **Select Your Region**:

   - Choose the AWS region where your Lightsail instance is or will be deployed.

6. **Generate the Key Pair**:

   - Enter a name for your key pair under **KeyPairName** (this can be any name you choose).
   - Click on **Generate key pair**.

7. **Download the Private Key**:
   - After the key pair is generated, download the private key file. **Note:** This is the only opportunity to download the private key, so make sure to save it securely.

---

---

# Set appropriate SSH permissions on private key(s) file(s)

## MacOS

**Set Permissions on Private Keys for SSH**:

- Make sure that you have saved the private key(s) of the old and new WordPress Bitnami instance locally.
- Run the following command in Terminal for each key:

```bash
chmod 400 /path/to/private-key.pem
```

---

## Windows (11) via WSL

**Set Permissions on Private Keys for SSH**:

- Make sure that you have saved the private key(s) of the old and new WordPress Bitnami instance locally.
- Press `Windows Key + X`, then select **Terminal** to open PowerShell.
- Use the `cd` command to navigate to the directory where the key(s) are located on your Windows machine. For example:

  ```powershell
  cd C:\path\to\keys
  ```

- Once in the correct directory, type:

  ```powershell
  wsl
  ```

- In the WSL terminal, copy the key(s) to your Ubuntu home directory:

  ```bash
  cp <private-key>.pem /home/ubuntu/
  ```

- Set the appropriate permissions on the key(s) in your Ubuntu home directory:

  ```bash
  chmod 400 /home/ubuntu/private-key.pem
  ```

  (Repeat for each key as needed.)

- After setting the permissions for each key, exit WSL:

  ```bash
  exit
  ```

---
