# PowerShell script to get temporary AWS credentials using MFA and configure AWS CLI

# Function to get temporary credentials using MFA
function Get-MfaCredentials {
    param (
        [string]$MfaDeviceArn = 'arn:aws:iam::805719057625:mfa/AlirezaIphoneGoogleAuthenticator',
        [string]$MfaToken,
        [string]$SourceProfile = 'Domotz-permanent'  # Use permanent creds from here
    )

    # Get session token using MFA and the permanent profile
    $response = aws sts get-session-token `
        --serial-number $MfaDeviceArn `
        --token-code $MfaToken `
        --profile $SourceProfile | ConvertFrom-Json

    if ($null -eq $response.Credentials) {
        Write-Host "❌ Error retrieving MFA credentials." -ForegroundColor Red
        exit 1
    }

    return $response.Credentials
}

# Function to configure AWS CLI with temporary credentials
function Set-AwsCliCredentials {
    param (
        [object]$Credentials,
        [string]$TargetProfile = 'Domotz'
    )

    aws configure set aws_access_key_id $Credentials.AccessKeyId --profile $TargetProfile
    aws configure set aws_secret_access_key $Credentials.SecretAccessKey --profile $TargetProfile
    aws configure set aws_session_token $Credentials.SessionToken --profile $TargetProfile

    Write-Host "`n✅ AWS CLI profile '$TargetProfile' now holds temporary MFA credentials (expires: $($Credentials.Expiration))" -ForegroundColor Green
}

# Main script execution
$defaultArn = 'arn:aws:iam::805719057625:mfa/AlirezaIphoneGoogleAuthenticator'
$MfaDeviceArn = Read-Host "Enter MFA device ARN (Press Enter to use default: $defaultArn)"
if ([string]::IsNullOrWhiteSpace($MfaDeviceArn)) {
    $MfaDeviceArn = $defaultArn
}

$MfaToken = Read-Host "Enter MFA token"

# Get credentials using Domotz-permanent and save into Domotz
$creds = Get-MfaCredentials -MfaDeviceArn $MfaDeviceArn -MfaToken $MfaToken
Set-AwsCliCredentials -Credentials $creds

# arn:aws:iam::805719057625:mfa/AlirezaIphoneGoogleAuthenticator