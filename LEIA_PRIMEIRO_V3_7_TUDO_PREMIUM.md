# MotoPRO V3.7 — Todos os recursos operacionais Premium

- **Pix R$ 9,99 / sete dias**: cobrança avulsa, confirmação automática; não é débito automático.
- Todos os módulos operacionais exigem plano ativo, período de teste válido ou cortesia. O admin é isento.
- Bloqueio aplicado no **backend**, não apenas na interface, em dashboard, lançamentos, metas, moto, assistente, integrações e consulta a campanhas.
- Sem assinatura: login, cadastro, assinatura, pagamento, renovação, área de conta e **exportação dos dados próprios** continuam disponíveis.
- O frontend exibe uma página de acesso Premium e botão para assinatura.
- Os dados financeiros anteriores permanecem salvos após o vencimento.
- As regras de autorização são reavaliadas em todas as requisições à API protegida.

## Homologação

1. Atualize **backend Heroku** e depois **frontend Vercel**. Não envie .env ao GitHub.
2. Mantenha `MP_ENFORCE_PREMIUM=false` enquanto testa: com este valor a cobrança existe, mas os módulos não ficam bloqueados.
3. Valide o pagamento Pix em conta de teste e o status do webhook; confirme ativação, vencimento, renovação e cortesia.
4. Só depois de homologar, em **Heroku → Config Vars**, defina `MP_ENFORCE_PREMIUM=true`. O frontend respeita a resposta da API automaticamente; sem recompilar o frontend.
5. Se quiser que **novos usuários não tenham teste gratuito**, altere `trialDays` para `0` no painel admin. Isso só afeta **novos cadastros**; períodos gratuitos já concedidos continuam válidos.
6. O botão de pagamento continua desativado se `MP_BILLING_ENABLED=false`; **não ative a exigência Premium** antes de habilitar com segurança a cobrança, ou usuários podem ficar sem acesso.

**Importante:** não existe mecanismo de participação automática em sorteios; campanhas continuam sujeitas às exigências legais. Excluir conta, política de privacidade e fluxo integral de direitos do titular precisam ser finalizados antes do lançamento comercial. Não interpretamos bloqueio Premium como autorização para negar acesso a dados pessoais.
