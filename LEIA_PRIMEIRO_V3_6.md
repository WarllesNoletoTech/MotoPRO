# MotoPRO V3.6 — renovação semanal por Pix e vencimento

## Alterações
- Premium expira exatamente ao atingir `activeUntil`. O middleware verifica a data em toda tentativa de utilizar recursos Premium (sem depender de cron).
- Status expirado é reconciliado ao abrir `/api/billing/me` ou a visão administrativa.
- Quando faltam **48 horas** para expirar, surge um aviso no aplicativo e a renovação Pix fica disponível.
- Um pagamento aprovado durante essas 48 horas adiciona 7 dias ao final da validade já adquirida (sem perder dias).
- Quando vence, os recursos Premium ficam restritos se `MP_ENFORCE_PREMIUM=true`; demais funcionalidades básicas permanecem disponíveis.
- A área de assinaturas mostra vencimentos e permite filtrar as que vencem nas próximas 48 horas.
- Nenhum Pix é debitado automaticamente: o entregador precisa autorizar/pagar a nova cobrança. O webhook continua confirmando o pagamento de forma automática.
- Avisos são **internos ao PWA enquanto ele está aberto**. Esta versão não envia WhatsApp, e-mail ou push quando o aplicativo está fechado.

## Publicação
1. Publique **backend-MotoPRO** no Heroku.
2. Publique **frontend-MotoPRO** na Vercel.
3. Configure os tokens de teste do Mercado Pago sem compartilhá-los. Não altere JWT nem MONGODB_URI para esta atualização.
4. Em homologação, mantenha `MP_ENFORCE_PREMIUM=false`. Teste com assinatura já vencida, com 48h restantes e com 3+ dias restantes, e confirme o bloqueio controlado antes de definir `true`.
5. Valide que o Pix aprovado estende o prazo uma única vez (idempotência) e que o admin mostra contagens corretas.
6. Não ative pagamentos reais antes de concluir a homologação.

**Não há cobrança recorrente automática por Pix**. As cobranças existentes não são alteradas. Um crédito antigo, se houver, continua sendo responsabilidade do Mercado Pago até cancelamento no provedor.
