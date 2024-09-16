<#
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
    try
    {
        return $PlainString | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
    }
    catch
    {
        Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $_"
        throw
    }
}
Export-ModuleMember -Function ConvertTo-PlainSecureString
