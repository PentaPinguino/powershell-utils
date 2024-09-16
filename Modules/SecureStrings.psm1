<#
 .Synopsis
  Converts a string to a plain secure string.

 .Description
  Converts a string to a plain secure string.

 .Parameter PlainString
  The string to convert.

 .Example
   # Generates a plain secure string.
   ConvertTo-PlainSecureString "Hello world!"
#>
function ConvertTo-PlainSecureString {
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String] $PlainString
        )
    try {
        return $PlainString | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
    } catch {
        Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $_"
        throw
    }
}
Export-ModuleMember -Function ConvertTo-PlainSecureString

<#
 .Synopsis
  Converts a secure string to a plain string.

 .Description
  Converts a secure string to a plain string.

 .Parameter PlainSecureString
  The secure string to convert.

 .Example
   # Generate a plain secure string, then convert it back to the original string
   ConvertTo-PlainSecureString "Hello world and converted back" | ConvertFrom-PlainSecureString
#>
function ConvertFrom-PlainSecureString {
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String] $PlainSecureString
        )
    try
    {
        $SecureString = ($PlainSecureString | ConvertTo-SecureString)
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
        return [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    }
    catch
    {
        Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $_"
        throw
    }
    finally
    {
        if ($null -ne $BSTR)
        {
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
        }
    }
}
Export-ModuleMember -Function ConvertFrom-PlainSecureString

<#
 .Synopsis
  Converts a string to a plain secure string and then saves it onto a file.

 .Description
  Converts a string to a plain secure string and then saves it onto a file.

 .Parameter PlainString
  The string to convert.

 .Parameter FilePath
  The filepath of the desired file.

 .Example
   # Generates a plain secure string.
   Out-SecureFile "Hello world!" "test.txt"
#>
function Out-SecureFile {
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String] $PlainString,
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String] $FilePath
        )
        try
        {
            ConvertTo-PlainSecureString $PlainString | Out-File $FilePath
        }
        catch
        {
            Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $_"
            throw
        }
}
Export-ModuleMember -Function Out-SecureFile

<#
 .Synopsis
  Reads a secure file and returns it as a plain string.

 .Description
  Reads a secure file and returns it as a plain string.

 .Parameter FilePath
  The filepath of the file to read.

 .Example
   # Reads a secure file and returns its plain content.
   Get-SecureContent "test.txt"
#>
function Get-SecureContent {
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String] $FilePath
    )
    try
    {
        Get-Content $FilePath | ConvertFrom-PlainSecureString
    }
    catch
    {
        Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $_"
        throw
    }
}
Export-ModuleMember -Function Get-SecureContent
