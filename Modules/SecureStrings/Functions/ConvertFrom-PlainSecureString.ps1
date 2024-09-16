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
