# MotoPRO V3.2 — Módulos administrativos

**Atenção:** trata-se de pacote para homologação. Não substituir os projetos em produção sem testar localmente e em deploy de prévia.

## Estrutura
- `backend-MotoPRO/` — Heroku, Node/Express/Mongoose
- `frontend-MotoPRO/` — Vercel, Next.js
- `README_DEPLOY.md` — publicação e checklist anterior

## Funcionalidades desta versão
1. **Motoboys:** busca, paginação, bloquear/desbloquear, visualização do último acesso, registro de motivo e trilha de auditoria.
2. **Assinaturas:** consulta por status e método, data final e valor contratado; cortesia administrativa independente dos pagamentos.
3. **Financeiro:** consulta por meio, status e período; apenas registros aprovados pelo provedor; conciliação de pagamentos de crédito confirmados nas chamadas de notificação.
4. **Campanhas:** cadastro e edição, publicação de campanhas baseadas em critérios objetivos com referência de regulamento aprovado, resultados em texto e visão pública. **Não realiza sorteio, inscrição automática ou seleção aleatória.**
5. **Configurações:** preço para novas contratações, dias de teste para novos usuários, cadastros abertos/fechados, mensagens informativas e descrição de benefícios.
6. **Admin único:** a role é verificada pelo backend, e o banco recebe índice parcial único para apenas uma conta `admin`.

## Segurança e limitações
- API admin exige sessão + role `admin`; se `ADMIN_EMAIL` estiver configurado, o e-mail precisa corresponder à variável.
- Alterações deixam rastro em `AdminAudit`. Não existe endpoint de promover outros administradores.
- Bloqueios impedem novo login e revogam efetivamente o acesso dos usuários bloqueados, mesmo com sessão existente.
- Cortesias são registradas separadamente em `CourtesyGrant`, não criam pagamentos fictícios.
- O valor alterado do plano se aplica a **novas cobranças**. Assinaturas recorrentes já vigentes preservam o valor contratado.
- Pix Automático não está implementado. Pix avulso e recorrência de cartão exigem homologação com Mercado Pago. O checkout de crédito precisa ser validado para **não oferecer débito**.
- Não é possível garantir conciliação financeira total sem validar webhooks e estornos com Mercado Pago.
- O painel exibe apenas registros aprovados conhecidos do backend. Não acessa finanças pessoais dos entregadores.
- Somente `MP_BILLING_ENABLED=true` após validação de credenciais, autorização e testes. Mantenha `MP_ENFORCE_PREMIUM=false` até testar cortesias e período gratuito.
- Não cole chaves, tokens, senhas ou URI de banco em chats, repositórios, capturas ou ZIPs.

## Testes locais
Em `backend-MotoPRO`: `npm install && npm run build && npm test`.
Em `frontend-MotoPRO`: `npm install && npm run build`.

Se o banco já contiver mais de um documento com role `admin`, a criação do índice `singleton_admin` falhará; verifique e mantenha **apenas uma conta administradora** antes de implantar.

## Variáveis Heroku
`NODE_ENV=production`, `MONGODB_URI`, `JWT_SECRET`, `APP_ORIGIN`, `ADMIN_EMAIL` (seu e-mail), `MP_BILLING_ENABLED=false`, `MP_ENFORCE_PREMIUM=false`, `MP_ACCESS_TOKEN` e `MP_WEBHOOK_SECRET` (somente credenciais válidas), `MP_PUBLIC_ORIGIN`. O Heroku fornece `PORT`.

## Variável Vercel
`API_INTERNAL_URL=https://SEU-APP.herokuapp.com`

**Não alterei automaticamente o ambiente de produção.** Atualize os dois projetos em repositórios separados e valide a prévia antes da publicação final.
