# Protege os arquivos de configuracao do MotoPRO sem apagar o .git nem credenciais locais.
$ErrorActionPreference='Stop'
$root=Split-Path -Parent $MyInvocation.MyCommand.Path
$ignore=Join-Path $root '.gitignore'
$enc=New-Object Text.UTF8Encoding($false)
$old=if(Test-Path $ignore){[IO.File]::ReadAllText($ignore)}else{''}
$add=@('**/.env','**/.env.*','!**/.env.example','!**/.env.heroku.example','!**/.env.vercel.example','**/node_modules/','**/dist/','**/.next/')
foreach($rule in $add){if(-not (@($old -split "`r?`n") -ccontains $rule)){$old+="`n$rule"}}
[IO.File]::WriteAllText($ignore,$old.TrimEnd()+"`n",$enc)
Write-Host 'OK: .gitignore atualizado preservando regras existentes.' -ForegroundColor Green
Push-Location $root
try {
  if ((Get-Command git -ErrorAction SilentlyContinue) -and (Test-Path (Join-Path $root '.git'))) {
    $tracked = @(git ls-files --cached -- backend-MotoPRO/.env frontend-MotoPRO/.env.local)
    if($tracked.Count -gt 0) {
      Write-Host 'ATENCAO: ha arquivos privados ja rastreados pelo Git.' -ForegroundColor Yellow
      Write-Host 'Remova SOMENTE do indice Git com:' -ForegroundColor Yellow
      Write-Host '  git rm --cached -- backend-MotoPRO/.env frontend-MotoPRO/.env.local' -ForegroundColor Yellow
      Write-Host 'Depois altere as credenciais expostas e faca commit das mudancas.' -ForegroundColor Yellow
    } else {Write-Host 'OK: .env e .env.local nao estao rastreados nos caminhos previstos.' -ForegroundColor Green}
  }
} finally {Pop-Location}
