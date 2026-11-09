# MotoPRO V3.1 — Login administrativo e primeiro administrador

## O que foi corrigido
- `/entrar`: após autenticação, usuários com `role=admin` vão para `/app/admin`; motoboys continuam em `/app`.
- O menu administrativo aparece apenas para usuários `admin` e a API `/api/admin/billing/overview` exige role de administrador verificada no MongoDB.
- Cadastro público continua criando **apenas** `driver`; **não existe** formulário público de criação de administradores.
- Comando `npm run admin:create` permite criar a conta inicial ou promover com confirmação uma conta já existente. A senha é digitada de forma oculta no terminal, nunca armazenada em Config Vars.
- Nenhum banco, senha ou chave real incluído no pacote.

## Subir a V3.1
1. Usar o backend `backend-MotoPRO` e frontend `frontend-MotoPRO`, em repositórios separados ou via Root Directory no monorepositório.
2. Subir para GitHub sem `.env`, `.env.local` nem tokens. A branch de produção só deve receber o código quando validado.
3. No Heroku em Settings > Config Vars, adicionar as variáveis descritas abaixo; no frontend Vercel adicionar `API_INTERNAL_URL`.
4. Testar `https://SEU-HEROKU.herokuapp.com/api/health` e `https://SEU-VERCEL.vercel.app/api/health`.
5. Criar a conta de administrador no **Heroku CLI**:

```bash
heroku login
heroku run bash -a motopro
npm run admin:create
```

Ao aparecer o prompt, informe o e-mail e nome (ou configure `ADMIN_EMAIL`/`ADMIN_NAME`), uma senha nova de no mínimo 12 caracteres e a confirmação. Em terminal com TTY, a senha não aparece. No final digite `exit`.

**Importante:** se o e-mail já está cadastrado como motoboy, o comando exige a palavra `PROMOVER` antes de conceder a role `admin` e redefine a senha dessa conta.

Se o Heroku CLI retornar que não está em terminal interativo, use um shell `heroku run bash` com TTY. Não coloque senha no Git, em logs, nem em `ADMIN_PASSWORD` persistente.

## Variáveis do HEROKU (Backend)

| Nome | Valor / uso |
|---|---|
| `NODE_ENV` | `production` |
| `MONGODB_URI` | URI real do MongoDB Atlas (segredo) |
| `JWT_SECRET` | nova chave aleatória forte (segredo, mínimo 32 caracteres) |
| `APP_ORIGIN` | `https://frontend-moto-pro.vercel.app` |
| `MP_BILLING_ENABLED` | `false` até homologar pagamentos |
| `MP_ACCESS_TOKEN` | access token privado do seu aplicativo Mercado Pago |
| `MP_WEBHOOK_SECRET` | chave privada para validar webhook Mercado Pago |
| `MP_PUBLIC_ORIGIN` | `https://motopro-cc33b74592eb.herokuapp.com` |
| `MP_ENFORCE_PREMIUM` | `false` até homologar acesso premium |
| `OPENAI_API_KEY` | opcional (transcrição de voz) |
| `OPENAI_TRANSCRIPTION_MODEL` | `gpt-4o-mini-transcribe` (opcional) |
| `ADMIN_EMAIL` | opcional; apenas para script de criação, não promove automaticamente |
| `ADMIN_NAME` | opcional; apenas para script de criação |

Não defina `PORT` no Heroku: é fornecida pela plataforma. Nunca configure `ADMIN_PASSWORD` no Heroku.

## Variáveis da VERCEL (Frontend)

```
API_INTERNAL_URL=https://motopro-cc33b74592eb.herokuapp.com
```

## Verificação
- Faça login em `/entrar` como administrador. O sistema deve redirecionar a `/app/admin`.
- Em `/api/auth/me`, verifique que `user.role` é `admin` (consulta autenticada).
- Confirme que motoboys não conseguem acessar `/api/admin/billing/overview` (403).
- Teste que `/cadastro` nunca permite selecionar ou enviar role `admin`.

**Mercado Pago:** Pix avulso e recorrência de crédito ainda requerem homologação; Pix Automático não deve ser anunciado como habilitado pela integração atual. **Premiação:** área de planejamento, sem sorteios automáticos.
