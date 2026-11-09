# MotoPRO — Nome completo e Qualidade da integração Mercado Pago

## Atualização

- Cadastro exige **Nome** e **Sobrenome** separados.
- Contas antigas com apenas um nome recebem uma tela obrigatória de atualização ao entrar, preservando usuário, lançamentos e Premium.
- Backend tem validação em `POST /api/auth/register`, `PATCH /api/auth/name`, nos endpoints Premium e em `POST /api/billing/pix`. A validação não fica apenas no navegador.
- Em **Configurações**, o usuário pode corrigir nome e sobrenome depois do cadastro.
- Pedido Pix (`POST /v1/orders`) inclui item "MotoPRO Premium - 7 dias", `items.quantity=1`, `items.unit_price` igual ao total da cobrança, categoria `services`, além de `payer.email`, `payer.first_name` e `payer.last_name`.
- Ao solicitar um Pix, o frontend tenta obter o Device ID pelo script oficial do Mercado Pago e repassa temporariamente como `X-meli-session-id` ao criar a ordem. Sem Device ID a geração do Pix continua funcionando (não depende do script externo).
- Preservados: valor semanal configurado no painel, idempotência, QR Code, Webhook, liberação automática, renovação, bloqueio Premium e integração com Rappidex.

## Alertas sobre a tela Qualidade da integração

- **Descrição da fatura do cartão** e **3DS** são recursos de cartão; o MotoPRO usa somente Pix. Não foi adicionado um `statement_descriptor` específico de cartão ao pagamento Pix para evitar rejeições da API.
- Não foi exigido **CPF, data de nascimento ou endereço** apenas para elevar nota. Esses campos são dados pessoais adicionais, não necessários ao Pix já em operação. O e-mail já é obrigatório no cadastro.
- A avaliação do Mercado Pago pode continuar mostrando recomendações de cartão/SDK e nota parcial mesmo quando o fluxo Pix estiver correto.
- `payer.registration_date`/`additional_info.payer.registration_date` não foram enviados sem confirmação de suporte na estrutura da API Orders de Pix; a data de criação continua armazenada localmente.

## Publicação

1. Publique o **backend e frontend** do MotoPRO; não são necessárias alterações no Rappidex.
2. Confirme o build de backend no Heroku e frontend na Vercel antes de testar.
3. Teste criar novo usuário, tentar cadastro só com primeiro nome, completar perfil de conta antiga no login, alterar perfil em Configurações e gerar um QR Code Pix SEM pagar.
4. Só depois teste um Pix real controlado e a liberação automática.
5. Não troque tokens, segredos ou outras variáveis de produção sem necessidade.

## Acesso de contas antigas

Se a conta tem somente um nome, o próximo acesso apresenta Nome + Sobrenome. A atualização preenche `User.name`, `User.firstName` e `User.lastName`, sem recriar a conta e sem afetar cobranças ou o histórico de ganhos. Nomes compostos informados no cadastro são preservados nos campos separados. Se o telefone também estiver ausente, a tela de telefone aparece depois.

## Referências do Mercado Pago

- https://www.mercadopago.com.br/developers/pt/docs/checkout-api-orders/payment-integration/websites/pix
- https://www.mercadopago.com.br/developers/pt/docs/checkout-api-orders/resources/migrate-payments-to-orders
- https://www.mercadopago.com.br/developers/pt/docs/checkout-api-orders/payment-management/improve-payment-approval/recommendations
