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

# Set appropriate SSH permissions on private key(s) file(s)

## MacOS

**Set Permissions on Private Keys for SSH**:

- Make sure that you have saved the private key(s) of the old and new WordPress Bitnami instance locally.
- Run the following command in Terminal for each key:

```bash
chmod 400 /path/to/private-key.pem
```

---

## Windows (11)

**Set Permissions on Private Keys for SSH**:

- Make sure that you have saved the private key(s) of the old and new WordPress Bitnami instance locally.
- To set restrictive permissions on the private key files, use the following steps:
- Right-click the `.pem` file and select **Properties**.
- Go to the **Security** tab, then click **Advanced**.
- Click on **Disable inheritance** and select **Remove all inherited permissions**.
- Click on **Add**, then **Select a principal**, and type your user name (Determine the user name using the "whoami" command in Powershell if you are not sure).
- Set permissions to **Read & execute** + **Read** only, and click **OK**.

---
