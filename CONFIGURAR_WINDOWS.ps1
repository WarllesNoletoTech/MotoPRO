# MotoPRO - configurar ambiente local nos nomes de pasta atuais.
# Nao substitui variaveis do Heroku ou da Vercel.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$back = Join-Path $root 'backend-MotoPRO'
$front = Join-Path $root 'frontend-MotoPRO'
if (-not (Test-Path (Join-Path $back 'package.json'))) { throw 'Pasta backend-MotoPRO nao encontrada.' }
if (-not (Test-Path (Join-Path $front 'package.json'))) { throw 'Pasta frontend-MotoPRO nao encontrada.' }

$backEnv = Join-Path $back '.env'
$frontEnv = Join-Path $front '.env.local'
if ((Test-Path $backEnv) -or (Test-Path $frontEnv)) {
  Write-Host 'Ja existem arquivos de configuracao local.' -ForegroundColor Yellow
  $r = Read-Host 'Deseja recriar ambos? Isso substituira a configuracao local atual. (S/N)'
  if ($r -notmatch '^(S|SIM|Y|YES)$') {
    Write-Host 'Arquivos existentes preservados. Nenhuma alteracao.'
    exit 0
  }
}

Write-Host ''
Write-Host 'MotoPRO - configuracao local (nao envie senhas ou o arquivo .env)' -ForegroundColor Cyan
$mongoUser = 'warllesb_db_user'
$defaultHost = 'dbmotopro.0minxuk.mongodb.net'
$hostEntered = Read-Host "Host do Atlas [ENTER = $defaultHost]"
$mongoHost = if ($hostEntered.Trim()) { $hostEntered.Trim() } else { $defaultHost }
if ($mongoHost -notmatch '^[a-zA-Z0-9.-]+\.mongodb\.net$') {
  throw 'Host do Atlas invalido. Copie o endereco exato do MongoDB Atlas > Connect > Drivers.'
}
$pwSecure = Read-Host "Digite a NOVA senha MongoDB de $mongoUser (oculta)" -AsSecureString
$bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwSecure)
try {
  $pwText = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
  if ([string]::IsNullOrWhiteSpace($pwText)) { throw 'Senha nao pode ser vazia.' }
  $pwEncoded = [Uri]::EscapeDataString($pwText)
} finally {
  [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
  Remove-Variable pwSecure, pwText -ErrorAction SilentlyContinue
}
$rand = New-Object byte[] 48
$rng = [Security.Cryptography.RandomNumberGenerator]::Create()
try { $rng.GetBytes($rand) } finally { $rng.Dispose() }
$jwt = [BitConverter]::ToString($rand).Replace('-', '').ToLowerInvariant()
$uri = "mongodb+srv://$($mongoUser):$($pwEncoded)@$($mongoHost)/motopro?retryWrites=true&w=majority"
$encoding = New-Object System.Text.UTF8Encoding($false)
$backendContent = @(
  'NODE_ENV=development',
  'PORT=4000',
  "MONGODB_URI=$uri",
  "JWT_SECRET=$jwt",
  'APP_ORIGIN=http://localhost:3000',
  'OPENAI_API_KEY=',
  'OPENAI_TRANSCRIPTION_MODEL=gpt-4o-mini-transcribe'
) -join "`n"
[IO.File]::WriteAllText($backEnv, "$backendContent`n", $encoding)
[IO.File]::WriteAllText($frontEnv, "API_INTERNAL_URL=http://localhost:4000`n", $encoding)

# Preserva o .gitignore existente e acrescenta apenas protecoes essenciais.
$ignore = Join-Path $root '.gitignore'
$old = if (Test-Path $ignore) { [IO.File]::ReadAllText($ignore) } else { '' }
$add = @('**/.env', '**/.env.*', '!**/.env.example', '!**/.env.heroku.example', '!**/.env.vercel.example', '**/node_modules/', '**/dist/', '**/.next/')
foreach ($rule in $add) {
  if ((@($old -split "`r?`n") -ccontains $rule) -eq $false) { $old += "`n$rule" }
}
[IO.File]::WriteAllText($ignore, $old.TrimEnd()+"`n", $encoding)
Write-Host 'OK: backend-MotoPRO/.env configurado; JWT de 96 caracteres gerada.' -ForegroundColor Green
Write-Host 'OK: frontend-MotoPRO/.env.local configurado para ambiente local.' -ForegroundColor Green
Write-Host 'OK: regras de protecao adicionadas ao .gitignore (sem remover as anteriores).' -ForegroundColor Green
Write-Host 'Heroku e Vercel exigem suas variaveis configuradas nos respectivos paineis.' -ForegroundColor Yellow
