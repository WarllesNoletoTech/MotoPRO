# MotoPRO V3.9 — Correção de tela de assinatura e compatibilidade com backend

## Por que a tela quebrou
A tela V3.8 assumia que toda resposta HTTP 200 de `GET /api/billing/me` continha `notice`, `access`, `renewalAllowed` e outros campos. Se o Heroku ainda executar código antigo ou uma resposta incompleta, a página de assinatura acessa `state.notice.status` e lança uma exceção de cliente. No painel principal, a mesma incompatibilidade era classificada indevidamente como erro de conexão.

## Correções
- Validação explícita do contrato da API antes de renderizar; nenhuma exceção de renderização por resposta ausente/incompatível.
- Mensagem de atualização pendente do backend, com botão Tentar novamente.
- O acesso Premium continua bloqueado quando não é possível validar a assinatura (fail closed).
- Proteção para `premiumBenefits` ausente em /api/public/settings.
- Uma tela de recuperação captura futuras exceções inesperadas na área logada e oferece tentar novamente sem perder o pagamento.
- A API do backend responde `contractVersion: 2`, sem mudar a lógica de cobrança.
- Pix avulso, QR Code, confirmação verde e renovação de 7 dias permanecem inalterados.

## Publicação
1. No GitHub, atualize o backend com o ZIP `MotoPRO_V3_9_BACKEND_HEROKU.zip` e publique no Heroku. Verifique logs do novo release.
2. Atualize frontend com `MotoPRO_V3_9_FRONTEND_VERCEL.zip` e publique na Vercel.
3. Faça login com conta de motoboy de teste sem plano, abra /app/assinatura, gere Pix e confirme no ambiente de homologação. Verifique também um motoboy com Premium válido e um admin.
4. Com as ferramentas do navegador, em Network > GET /api/billing/me > Response, confirme presença de `notice`, `access`, `renewalAllowed`, `contractVersion: 2` e status 200. **Não compartilhe cookies, token ou dados privados**.
5. Não mexa nos tokens do Mercado Pago nem altere créditos bancários.

**Observação:** o backend da V3.7/V3.8 já continha os campos da assinatura no código-fonte. HTTP 200 no log do Heroku não prova que os campos corretos foram entregues; o corpo da resposta e o release implantado determinam a causa.
