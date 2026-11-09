# MotoPRO — Correção da homologação de assinatura no crédito

## Diagnóstico

Erro novo do Mercado Pago: HTTP 400 — `Both payer and collector must be real or test users`.

A periodicidade `frequency:7, frequency_type:days` já está corrigida.
O erro restante é de **mistura de comprador real com vendedor/credencial de teste**, não de recorrência.

## Como testar sem mexer no e-mail real do administrador

1. No Mercado Pago Developers, obtenha uma conta **compradora de teste** e confira o e-mail da conta (não apenas o nome de usuário). Crie/identifique também o vendedor de teste para a integração de Assinaturas, seguindo as regras da plataforma.
2. Confirme que o `MP_ACCESS_TOKEN` do Heroku pertence ao ambiente e vendedor de **teste** da aplicação de Assinaturas. Consulte as instruções da plataforma: dependendo do fluxo, pode ser necessário utilizar a aplicação e credenciais da conta vendedora de teste.
3. No Heroku **apenas para homologação**, adicione:

```env
MP_CREDIT_TEST_MODE=true
MP_CREDIT_TEST_PAYER_EMAIL=EMAIL_DA_CONTA_COMPRADORA_DE_TESTE@testuser.com
MP_ENFORCE_PREMIUM=false
```

Não use o e-mail exemplo literalmente. O acesso de teste ao cartão é restrito ao `role=admin`. Não mude `MONGODB_URI` nem `JWT_SECRET`.
4. Reinicie o app/redeploy se necessário e faça login no MotoPRO com sua conta de administrador. Clique em `Assinar no crédito`.
5. Ao abrir o Mercado Pago, use a conta COMPRADORA de teste para autorizar com cartão de teste. Não utilize cartão real.
6. Confira webhooks, pagamento autorizado, `billingpayments` e `billingsubscriptions`; Premium só deve ser concedido após confirmação de cobrança aprovada.

**Alternativa sem variável especial:** registre um usuário normal de teste no MotoPRO usando o e-mail da conta COMPRADORA de teste; não ative `MP_CREDIT_TEST_MODE` nem `MP_CREDIT_TEST_PAYER_EMAIL`. Teste com esse usuário e as credenciais corretas.

## Atenção antes de publicar em produção

- Remova `MP_CREDIT_TEST_MODE` e `MP_CREDIT_TEST_PAYER_EMAIL` do Heroku.
- Mantenha `MP_ENFORCE_PREMIUM=false` até homologar todo o fluxo.
- A implementação falha de propósito se houver um e-mail de teste configurado sem o modo de teste ativo, evitando a utilização acidental em produção.
- O modo de teste não cria assinaturas verdadeiras e não valida cobranças reais.
- Este patch não altera Pix, frontend nem regras de datas.

## Arquivos alterados

- `backend-MotoPRO/src/routes/billing.ts`
- `backend-MotoPRO/src/services/creditTestPayer.ts`
- `backend-MotoPRO/src/services/creditTestPayer.test.ts`
- `backend-MotoPRO/src/services/mercadoPago.ts`
- `backend-MotoPRO/.env.example`
- `backend-MotoPRO/.env.heroku.example`
- `backend-MotoPRO/package.json`

Documentação oficial: https://www.mercadopago.com.br/developers/pt/docs/subscriptions/integration-test/payment-approval
