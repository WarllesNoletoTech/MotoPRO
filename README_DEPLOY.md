# MotoPRO — pastas corrigidas para seu repositorio

Estrutura atual confirmada pelas imagens:

```
MotoPRO/                   <- repositorio Git (a pasta .git deve ser preservada)
├── backend-MotoPRO/       <- API Node/Express/MongoDB
├── frontend-MotoPRO/      <- Next.js/PWA
├── package.json           <- npm workspaces + build Heroku no diretorio raiz
├── Procfile               <- Heroku executa npm start no monorepo
├── CONFIGURAR_WINDOWS.bat
├── INSTALAR_WINDOWS.bat
├── INICIAR_TUDO_WINDOWS.bat
└── VERIFICAR_CONEXAO_WINDOWS.bat
```

## Usar os ZIPs

- Se ja tem os dois projetos configurados em MotoPRO, extraia **MotoPRO_PATCH_PASTAS_ATUAIS.zip** na pasta MotoPRO. Ele nao substitui todos os codigos e nao inclui .env, nem .git.
- Se quer uma copia completa organizada, use **MotoPRO_COMPLETO_PASTAS_ATUAIS.zip**, que traz o frontend e backend da ultima versao disponibilizada, e a correcao de tipagem de Goal no backend.
- Nao substitua ou apague a pasta `.git` do seu repositorio existente.
- Nao comite arquivos `.env` ou `.env.local`. O script de configuracao tenta proteger o `.gitignore` existente, mas arquivos que ja foram versionados exigem remocao do indice Git.

**Antes de publicar**, execute `PROTEGER_SEGREDOS_GIT_WINDOWS.bat` para preservar as regras existentes do `.gitignore` e conferir se ha segredos rastreados. O script nao altera arquivos do Git historico.

## Deploy pelo mesmo repositorio GitHub

### Heroku

1. Conecte o repositorio cuja raiz contem `package.json`, `Procfile`, `backend-MotoPRO` e `frontend-MotoPRO`.
2. Execute `npm install` uma vez na raiz e inclua o `package-lock.json` gerado no commit para builds reproduziveis. O script de build da raiz compila somente `backend-MotoPRO`; a inicializacao da raiz executa a API.
3. Em Settings > Config Vars configure `NODE_ENV=production`, `MONGODB_URI` (credencial renovada), `JWT_SECRET` (nova chave segura), `APP_ORIGIN=https://frontend-moto-pro.vercel.app`.
4. **Nao** inclua `PORT` manualmente; o Heroku fornece esse valor.
5. Deploy e teste `https://SEU-APP.herokuapp.com/api/health`.

### Vercel

1. Importe o mesmo repositorio GitHub no projeto frontend-moto-pro.
2. Settings > Build and Deployment > Root Directory = `frontend-MotoPRO` (sem barra inicial).
3. Variavel `API_INTERNAL_URL=https://SEU-APP.herokuapp.com` (URL do backend, sem barra final nem /api).
4. Refaca o deploy apos salvar variaveis e Root Directory.
5. Teste `https://frontend-moto-pro.vercel.app/api/health` e o cadastro.

Se voce ja publicou o frontend em outro repositorio separado, nao precisa mudar sua estrutura atual; o Root Directory so deve ser `frontend-MotoPRO` se essa pasta existir naquele repositorio.

## Iniciar localmente (opcional)

1. `CONFIGURAR_WINDOWS.bat`: pergunta o host do Atlas, solicita a senha **nova** ocultamente e cria uma JWT aleatoria localmente. Nao use senhas expostas nas capturas anteriores.
2. `INSTALAR_WINDOWS.bat`: instala dependencias do monorepo.
3. `VERIFICAR_CONEXAO_WINDOWS.bat`: verifica acesso ao Atlas.
4. `INICIAR_TUDO_WINDOWS.bat`: inicia API porta 4000 e frontend porta 3000.

## Observacoes

- A correção `src/models/Goal.ts` para o erro `weeklyTargetCents` faz parte da versao completa e do patch.
- A raiz possui um `package.json` com npm workspaces. Isso evita que o Heroku tente interpretar a raiz como um projeto sem package.json.
- As instalacoes e o deploy final precisam ser validados no Windows/Heroku; o ZIP nao leva `node_modules` nem dependencias preinstaladas.
- Esta versao nao traz nenhuma chave real embutida no codigo e nao muda dados no MongoDB.
