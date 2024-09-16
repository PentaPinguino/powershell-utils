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