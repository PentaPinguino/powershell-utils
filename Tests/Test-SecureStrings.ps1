Import-Module .\Modules\SecureStrings\SecureStrings.psm1

# Generate a plain secure string
ConvertTo-PlainSecureString "Hello world!"

# Generate a plain secure string, then convert it back to the original string
ConvertTo-PlainSecureString "Hello world and converted back" | ConvertFrom-PlainSecureString

# Generate a plain secure string and save it onto a file
$TestFile = "test.txt"
Out-SecureFile "Hello world from a file!" $TestFile

# Read back the file and convert it back to a plain string
Get-SecureContent "test.txt"

# Clean the test file
if (Test-Path $TestFile) {
    Remove-Item $TestFile -verbose
}
