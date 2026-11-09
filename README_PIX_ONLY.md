# MotoPRO — Versão inicial somente Pix (R$ 9,99 por 7 dias)

## Modificações
- Removida a oferta de cartão da página de assinatura.
- `POST /api/billing/credit` bloqueado com HTTP 410, mesmo se o token de cartão ainda estiver configurado.
- `GET /api/billing/plan` anuncia somente `pix`.
- Indicadores `billingEnabled` refletem apenas a configuração do MotoPRO PIX, inclusive na administração.
- Preservados QR Code, Pix Copia e Cola, confirmação, idempotência e controle de acesso de 7 dias.
- Mantido o cancelamento de **assinaturas antigas por cartão** para não deixar cobranças existentes sem gerenciamento.
- Histórico de crédito mantido na área administrativa para conciliação e auditoria.

## Configuração Heroku (valores apenas de exemplo)
```
MP_PIX_ACCESS_TOKEN=TOKEN_DA_APLICACAO_MOTOPRO_PIX
MP_PIX_WEBHOOK_SECRET=SEGREDO_DOS_WEBHOOKS_DE_ORDERS
MP_BILLING_ENABLED=true
MP_ENFORCE_PREMIUM=false
```
- Ao finalizar a homologação, configure a exigência de Premium com cuidado.
- Pode remover `MP_CREDIT_TEST_MODE` e `MP_CREDIT_TEST_PAYER_EMAIL` do Heroku.
- Se houver assinatura de cartão já autorizada, **desative-a explicitamente no Mercado Pago** e confirme o cancelamento antes de remover `MP_ACCESS_TOKEN` ou `MP_WEBHOOK_SECRET`. Apenas esconder o botão não cancela uma recorrência existente.
- **Pix aqui não é Pix Automático**: novo pagamento manual a cada 7 dias, confirmação automática pela API/webhook.
- Não inclua `.env` reais nos ZIPs ou no GitHub; rode builds antes de publicar.

## Publicação
1. Deploy do `backend-MotoPRO` no Heroku.
2. Deploy do `frontend-MotoPRO` na Vercel.
3. Confira `/api/billing/plan`, que deve retornar `methods: ["pix"]`.
4. Confira que `POST /api/billing/credit` retorna HTTP 410.
5. Teste a geração do Pix e a confirmação no ambiente de homologação.
