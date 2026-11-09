# MotoPRO V3.14 — Preparação para Pix real (Mercado Pago / API Orders)

Este pacote parte da V3.14 (cores de status). O frontend foi mantido sem alterações.
**Não altera credenciais nem ativa pagamentos na conta Mercado Pago/Heroku.**

## O que foi verificado no código

- `POST /api/billing/pix`: cria a order via `MP_PIX_ACCESS_TOKEN` em `/v1/orders`.
- `POST /api/webhooks/mercadopago/orders`: valida a assinatura `MP_PIX_WEBHOOK_SECRET` e consulta a order no Mercado Pago.
- Conclusão da order: apenas `processed/accredited` na order e no pagamento, com valor e referência vinculados à cobrança, autoriza Premium.
- Preço inicial: R$ 9,99 por 7 dias (`999` centavos). **Confirme no painel Administração > Configurações que o preço efetivo continua R$ 9,99; o administrador pode alterá-lo.**
- A renovação é por novo Pix, **não é Pix Automático**. Pode ser feita nas últimas 48 horas do prazo pago; os dias restantes são preservados.
- Exigência Premium no backend é permanente para entregadores; `MP_ENFORCE_PREMIUM` é uma configuração legada, sem efeito no controle de acesso da V3.14.
- Bloqueio após vencimento ocorre na própria consulta, sem agendador.

## Reforços deste pacote

1. A aplicação de pagamentos aprovados à assinatura agora usa atualização condicional com nova tentativa: evita perder uma extensão quando dois pagamentos são conciliados simultaneamente e mantém idempotência para o mesmo pagamento.
2. `POST /api/billing/refresh` também pode reconciliar o último Pix **já marcado como aprovado**. Assim, uma falha entre salvar a aprovação e atualizar o direito Premium pode ser recuperada por nova consulta.

## Config Vars (Heroku: app `motopro` > Settings)

| Variável | Uso | Conduta para produção |
|---|---|---|
| `MP_BILLING_ENABLED` | Liga emissão de cobranças Pix | `true` após verificação |
| `MP_PIX_ACCESS_TOKEN` | Token da aplicação **MotoPRO Pix** | Trocar para token válido de **produção** na própria conta Mercado Pago; não enviar por chat |
| `MP_PIX_WEBHOOK_SECRET` | Verifica os Webhooks da aplicação MotoPRO Pix | Usar **assinatura secreta do Webhook de produção** correspondente; nunca enviar por chat |
| `MP_PUBLIC_ORIGIN` | URL pública do backend | HTTPS do app Heroku, sem barra final |
| `APP_ORIGIN` | URL do frontend autorizada | HTTPS exato do frontend Vercel |
| `NODE_ENV` | Modo de execução Node | `production` |
| `MP_ACCESS_TOKEN` / `MP_WEBHOOK_SECRET` | Integração antiga (pagamentos/cartão, cancelamento de assinaturas antigas) | Manter até conferir que **não existem assinaturas antigas por cartão**; não são usados na criação do Pix Orders atual |
| `MP_ENFORCE_PREMIUM` | Legado | Pode ser removida: não controla o bloqueio Premium desta versão |
| `MP_CREDIT_TEST_MODE` / `MP_CREDIT_TEST_PAYER_EMAIL` | Testes antigos do cartão | Podem ser removidas da configuração de produção; o cartão já está desativado |

**Não remova:** `MONGODB_URI`, `JWT_SECRET`, `MP_PIX_ACCESS_TOKEN`, `MP_PIX_WEBHOOK_SECRET`, `APP_ORIGIN` e `MP_PUBLIC_ORIGIN`.

**Segurança:** por terem aparecido em uma captura de tela, planeje a rotação de `JWT_SECRET`, credenciais MongoDB, token e assinatura do Mercado Pago. Execute com segurança: a troca do JWT derruba sessões; a troca do Mongo precisa ser coordenada com o Heroku; a troca da assinatura de Webhook exige atualizar o Heroku de modo sincronizado. Nunca comite segredos, faça prints da coluna Value ou envie tokens completos.

## Configuração no Mercado Pago (MotoPRO Pix)

1. Entre na integração **MotoPRO Pix** (Checkout Transparente), não na aplicação antiga `MotoPRO` (Assinaturas).
2. Em Credenciais > Produção, ative e confirme a conta de produção; configure no Heroku o token de **produção** da própria aplicação. O prefixo `APP_USR` não prova sozinho que é uma credencial de produção.
3. Em **Configuração de Webhooks**, escolha **Produção** e configure a URL HTTPS:

   `https://<SEU-BACKEND-HEROKU>/api/webhooks/mercadopago/orders`

   Substitua `<SEU-BACKEND-HEROKU>` pelo host efetivo de `MP_PUBLIC_ORIGIN`, sem `https://`. Para o domínio documentado neste projeto, o caminho é `/api/webhooks/mercadopago/orders`.

4. Selecione o evento **Order (Mercado Pago)**. Use no Heroku a assinatura secreta gerada para **esse Webhook de produção**.
5. Simule a recepção da notificação no painel e verifique a resposta da rota. A simulação testa a entrega e assinatura; **não equivale a pagamento real aprovado**.
6. Faça uma cobrança Pix real de R$ 9,99, usando uma conta de comprador legítima, confira a identificação do recebedor antes de pagar, aguarde a conciliação e confira o painel financeiro.

## Validação antes de liberar clientes

- Conta de entregador sem teste, cortesia ou pagamento: recursos protegidos retornam HTTP 402; `/api/billing/me` e `/api/billing/pix` continuam acessíveis após login.
- Pix pendente: mostra QR Code e **não** libera Premium.
- Pix aprovado: último pagamento aprovado, assinatura válida por 7 dias e recursos liberados.
- Reenvio do mesmo Webhook e botão "Verificar confirmação": **não** somam 7 dias novamente.
- Uma renovação legítima durante as últimas 48 horas **acrescenta** 7 dias ao vencimento pago existente.
- Vencimento: após a data/hora limite, bloqueia recursos Premium automaticamente. O administrador é isento.
- Reembolso/estorno: marca o pagamento para conferência e **exige conciliação administrativa** dos direitos já concedidos. Esta versão NÃO revoga automaticamente o prazo por estorno.
- Se já existir um plano de cartão antigo, sua gestão precisa de revisão separada antes de remover as variáveis legadas.

## Publicação

- Se a V3.14 já foi publicada, publique a pasta `backend-MotoPRO` desta versão no repositório que entrega o Heroku. O `frontend-MotoPRO` permanece idêntico à V3.14.
- Faça deploy em homologação ou com impacto controlado, backup do banco e acompanhamento dos logs. Não limpe coleções de pagamentos/assinaturas e não regenere o JWT desnecessariamente.
- Teste build/typecheck no ambiente Node **24.x** adotado pelo projeto. O pacote aqui foi analisado estaticamente; apenas o deploy conectado a MongoDB e Mercado Pago confirma o comportamento real.

Documentação oficial do Mercado Pago:
- https://www.mercadopago.com.br/developers/pt/docs/checkout-api-orders/notifications
- https://www.mercadopago.com.br/developers/pt/docs/checkout-api-orders/payment-management/status/order-status
