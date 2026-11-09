# MotoPRO - configuracao local segura. NUNCA salvar senha de banco no ZIP.
param()
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$backendDir = Join-Path $root 'backend'
$frontendDir = Join-Path $root 'frontend'
$envFile = Join-Path $backendDir '.env'
$frontEnv = Join-Path $frontendDir '.env.local'

$mongoUser = 'warllesb_db_user'
$mongoHost = 'dbmotopro.0minxuk.mongodb.net'
$mongoDb = 'motopro'

Write-Host ''
Write-Host '========================================'
Write-Host '     CONFIGURACAO SEGURA - MotoPRO'
Write-Host '========================================'
Write-Host "Usuario MongoDB: $mongoUser"
Write-Host "Cluster MongoDB: $mongoHost"
Write-Host "Banco de dados: $mongoDb"
Write-Host ''
Write-Host 'ATENCAO: a senha anterior apareceu em capturas de tela.' -ForegroundColor Yellow
Write-Host 'Troque a senha desse usuario em MongoDB Atlas > Database Access.' -ForegroundColor Yellow
Write-Host 'Use aqui a NOVA senha. Ela nao sera exibida durante a digitacao.'
Write-Host ''

if (Test-Path -LiteralPath $envFile) {
  $choice = Read-Host 'Ja existe backend\.env. Substituir configuracao local? (S/N)'
  if ($choice -notmatch '^(s|sim|y|yes)$') {
    Write-Host 'Arquivo existente preservado; nenhuma alteracao realizada.'
    exit 0
  }
}

$pwSecure = Read-Host 'Nova senha do usuario MongoDB (entrada oculta)' -AsSecureString
$bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwSecure)
try {
  $password = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
  if ([string]::IsNullOrWhiteSpace($password)) {
    throw 'A senha nao pode ficar vazia.'
  }
  # A senha em uma URI deve ser percent-encoded (@, :, /, #, %, $, etc.)
  $encodedPassword = [System.Uri]::EscapeDataString($password)
} finally {
  [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
  Remove-Variable pwSecure -ErrorAction SilentlyContinue
  Remove-Variable password -ErrorAction SilentlyContinue
}

$bytes = New-Object byte[] 48
$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
try { $rng.GetBytes($bytes) } finally { $rng.Dispose() }
$jwtSecret = [System.BitConverter]::ToString($bytes).Replace('-', '').ToLowerInvariant()
$uri = "mongodb+srv://$($mongoUser):$($encodedPassword)@$($mongoHost)/$($mongoDb)?retryWrites=true&w=majority"

$lines = @(
  'NODE_ENV=development'
  'PORT=4000'
  "MONGODB_URI=$uri"
  "JWT_SECRET=$jwtSecret"
  'APP_ORIGIN=http://localhost:3000'
  'OPENAI_API_KEY='
  'OPENAI_TRANSCRIPTION_MODEL=gpt-4o-mini-transcribe'
)
# UTF-8 sem BOM para compatibilidade com dotenv
$utf8 = [System.Text.UTF8Encoding]::new($false)
[System.IO.File]::WriteAllText($envFile, (($lines -join "`n") + "`n"), $utf8)
[System.IO.File]::WriteAllText($frontEnv, "API_INTERNAL_URL=http://localhost:4000`n", $utf8)

Write-Host ''
Write-Host 'OK - backend\.env criado com cluster e usuario corretos.' -ForegroundColor Green
Write-Host 'OK - JWT_SECRET aleatoria de 96 caracteres gerada localmente.' -ForegroundColor Green
Write-Host 'OK - frontend\.env.local configurado.' -ForegroundColor Green
Write-Host 'Segredos nao foram exibidos. Nao envie os arquivos .env por mensagem ou Git.' -ForegroundColor Yellow
Write-Host 'Agora execute: INSTALAR_WINDOWS.bat e INICIAR_TUDO_WINDOWS.bat'
