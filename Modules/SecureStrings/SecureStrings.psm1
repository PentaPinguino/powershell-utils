try
{
    Push-Location $PSScriptRoot
    
    $SecureStringsScriptsPath = '.\Functions'

    . ("$SecureStringsScriptsPath\ConvertTo-PlainSecureString.ps1")
    . ("$SecureStringsScriptsPath\ConvertFrom-PlainSecureString.ps1")
    . ("$SecureStringsScriptsPath\Out-SecureFile.ps1")
    . ("$SecureStringsScriptsPath\Get-SecureContent.ps1")
}
catch
{
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber) while loading required scripts: $_"
    throw
}
finally
{
    Pop-Location
}
