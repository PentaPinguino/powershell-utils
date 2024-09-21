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
            ConvertTo-PlainSecureString $PlainString | Set-Content $FilePath
        }
        catch
        {
            Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $_"
            throw
        }
}
Export-ModuleMember -Function Out-SecureFile
