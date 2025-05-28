import subprocess
import json
import os

# Default MFA device ARN
DEFAULT_MFA_DEVICE_ARN = (
    "arn:aws:iam::805719057625:mfa/AlirezaIphoneGoogleAuthenticator"
)
# Profile names
PERMANENT_PROFILE = "Domotz-permanent"
TEMP_PROFILE = "Domotz"


def get_mfa_credentials(mfa_device_arn, mfa_token, source_profile=PERMANENT_PROFILE):
    """
    Get temporary AWS credentials using MFA.
    """
    # Run the AWS CLI command to get temporary credentials
    result = subprocess.run(
        [
            "aws",
            "sts",
            "get-session-token",
            "--serial-number",
            mfa_device_arn,
            "--token-code",
            mfa_token,
            "--profile",
            source_profile,
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )

    if result.returncode != 0:
        print(f"❌ Error retrieving MFA credentials: {result.stderr}")
        exit(1)

    # Parse the response from the AWS CLI command
    credentials = json.loads(result.stdout).get("Credentials", {})
    if not credentials:
        print("❌ Error retrieving MFA credentials.")
        exit(1)

    return credentials


def set_aws_cli_credentials(credentials, target_profile=TEMP_PROFILE):
    """
    Set the temporary credentials in the AWS CLI config for the specified profile.
    """
    # Set the temporary credentials in AWS CLI config
    subprocess.run(
        [
            "aws",
            "configure",
            "set",
            "aws_access_key_id",
            credentials["AccessKeyId"],
            "--profile",
            target_profile,
        ],
        check=True,
    )
    subprocess.run(
        [
            "aws",
            "configure",
            "set",
            "aws_secret_access_key",
            credentials["SecretAccessKey"],
            "--profile",
            target_profile,
        ],
        check=True,
    )
    subprocess.run(
        [
            "aws",
            "configure",
            "set",
            "aws_session_token",
            credentials["SessionToken"],
            "--profile",
            target_profile,
        ],
        check=True,
    )

    print(
        f"\n✅ AWS CLI profile '{target_profile}' now holds temporary MFA credentials (expires: {credentials['Expiration']})"
    )


def main():
    # Ask for MFA device ARN or use default
    mfa_device_arn = input(
        f"Enter MFA device ARN (Press Enter to use default: {DEFAULT_MFA_DEVICE_ARN}): "
    ).strip()
    if not mfa_device_arn:
        mfa_device_arn = DEFAULT_MFA_DEVICE_ARN

    # Ask for MFA token
    mfa_token = input("Enter MFA token: ").strip()

    # Get the temporary credentials
    credentials = get_mfa_credentials(mfa_device_arn, mfa_token)

    # Set the temporary credentials in the AWS CLI
    set_aws_cli_credentials(credentials)


if __name__ == "__main__":
    main()
