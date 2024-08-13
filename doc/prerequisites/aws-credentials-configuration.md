Hier ist der korrigierte Guide mit den fehlenden Schritten:

# AWS Credentials Configuration

If you belong to an AWS organization and can access your account via SSO, you can also use a temporary access key from the AWS access portal instead of creating a permanent one using the following guide. If you have no clue what I am talking about here, just follow the guide below.

## Steps to Create an Access Key for Terraform

![AWS Credentials Configuration GIF](/doc/img/aws-programatic-access.gif)

### 1. **Navigate to the IAM Console**

- Sign in to the [AWS Management Console](https://aws.amazon.com/console/).
- From the AWS Management Console, navigate to **IAM** (Identity and Access Management).
- In the left-hand navigation pane, select **Users**.

### 2. **Select or Create a User**

- Click on **Create user**.
  - Enter a username, such as `terraform`.
  - Click **Next**.

### 3. **Attach Policies**

- On the **Set Permissions** step, choose **Attach policies directly**.
- In the search bar, type `AdministratorAccess`.
- Select the checkbox next to the **AdministratorAccess** policy to grant full programmatic access to your user.

Optionally, you can also create and attach a custom policy that grants only the specific permissions needed, such as full access to Lightsail, if you prefer more restrictive access instead of using broader, predefined policies. P.S. There is no managed LightsailFullAccess policy provided by AWS by default.

### 4. **Complete User Creation**

- Continue through the steps to review your settings, and finally click **Create user**.

### 5. **Create Access Key**

- After the user is created, you will be redirected to a list of all users. Click on the username of the newly created user (e.g., `terraform`).
- Navigate to the **Security credentials** tab.
- Scroll down to the **Access keys** section and click on **Create access key**.
- Select the use case **Command Line Interface (CLI)**.
- Confirm by checking the checkbox "I understand the above recommendation and want to proceed to create an access key."
- Click **Next**.

### 6. **Retrieve Access Key**

- You will be presented with the **Access key ID** and **Secret access key**.
- **Download** the `.csv` file containing these credentials or copy them manually and store them securely. **Note:** This is the only time you will be able to see the secret access key.

### 7. **Configure AWS CLI with Your Access Keys**

#### **MacOS:**

- Open your **Terminal**.
- Run the following command to configure the AWS CLI:

  ```bash
  aws configure
  ```

- Enter the **Access key ID** and **Secret access key** when prompted.
- Specify your desired AWS region (e.g., `eu-central-1`).
- Leave the default output format as `json` or choose another format if preferred.

Example configuration process:

```bash
$ aws configure
AWS Access Key ID [None]: <Your Access Key ID>
AWS Secret Access Key [None]: <Your Secret Access Key>
Default region name [None]: eu-central-1
Default output format [None]: json
```

#### **Windows:**

- Open **PowerShell**.
- Run the following command to configure the AWS CLI:

  ```powershell
  aws configure
  ```

- Enter the **Access key ID** and **Secret access key** when prompted.
- Specify your desired AWS region (e.g., `eu-central-1`).
- Leave the default output format as `json` or choose another format if preferred.

Example configuration process:

```powershell
PS C:\> aws configure
AWS Access Key ID [None]: <Your Access Key ID>
AWS Secret Access Key [None]: <Your Secret Access Key>
Default region name [None]: eu-central-1
Default output format [None]: json
```

### 8. **Verify Configuration**

- To ensure everything is configured correctly, you can run the following command to list your available Lightsail resources:

  ```bash
  aws lightsail get-instances
  ```

- If configured correctly, this command will return a list of your Lightsail instances (if any exist) in the specified region.

---
