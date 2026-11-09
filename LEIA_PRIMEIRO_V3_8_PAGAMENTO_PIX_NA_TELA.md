# MotoPRO V3.8 — Pix direto na tela de acesso Premium

## Alterações
- Sem assinatura paga: tela informa **Você ainda não ativou o MotoPRO Premium** e apresenta **Gerar Pix para ativar**.
- Assinatura paga expirada: tela informa **Sua assinatura Premium venceu** e apresenta **Gerar Pix para renovar**.
- Clicando no botão, o frontend chama `POST /api/billing/pix` (o backend reaproveita um Pix pendente válido) e abre a tela **Assinatura** com o QR Code.
- Na tela Assinatura, mensagens diferentes para **não ativada**, **vencida** e **vence em breve**, junto ao botão Pix e ao QR Code.
- Falha de consulta: mostra **Não foi possível consultar sua assinatura** e botão de tentar novamente. Falha de conexão **não é confundida com vencimento**. Na página de Assinatura, erro de consulta também pode ser tentado de novo em vez de ficar carregando sem fim.
- Nenhuma alteração nas APIs de pagamento, bancos, webhooks, contas ou preços. A verificação de aprovação Pix e o OK verde da V3.5 permanecem.

## Deploy
1. Publicar o conteúdo de `frontend-MotoPRO` no repositório frontend e fazer deploy na Vercel.
2. Não é necessário publicar o backend novamente se a V3.7 já estiver no Heroku.
3. Para a tela de bloqueio aparecer, `MP_ENFORCE_PREMIUM=true` no Heroku, após validar o Pix em ambiente apropriado.

## Atenção
A captura de tela anterior indicava **falha de verificação**; isso **não prova** que a assinatura venceu. Se o erro continuar, verificar no navegador `GET /api/billing/me` (status HTTP) e os logs do Heroku. Esta versão mantém um tratamento específico de falha, sem afirmar falso vencimento.

## Verificações
- Sintaxe TS/TSX dos arquivos alterados (sem o build Next.js completo).
- Integridade dos ZIPs e exclusão de `.env` e `node_modules`.
