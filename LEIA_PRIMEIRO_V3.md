# MotoPRO V3 — Assinaturas com Mercado Pago (homologação)

Esta versão preserva os diretórios **backend-MotoPRO** (Heroku) e **frontend-MotoPRO** (Vercel). Não envie credenciais ao GitHub.

## Entregue
- Preço do MotoPRO Premium: **R$ 9,99 por 7 dias**.
- **Pix avulso**: geração de cobrança e Pix copia e cola, consulta e atualização por webhook do Mercado Pago. Não equivale a Pix Automático. Renovação manual a cada sete dias.
- **Crédito recorrente**: início de assinatura com `preapproval` no Mercado Pago e link de autorização. Deve ser validado no ambiente de homologação para garantir que apenas crédito seja oferecido; nunca habilite sem esse teste.
- Acesso Premium: período de teste, validade e proteção opcional do assistente inteligente.
- Painel administrativo inicial: contas, assinaturas ativas e pagamentos Pix confirmados. **Não soma cobranças de crédito** como receita até existir conciliação específica.
- Seção informativa de campanhas/prêmios: **não realiza sorteio, não distribui números e não cria participação paga**.

## Variáveis privadas (Heroku → Config Vars)

```dotenv
NODE_ENV=production
MONGODB_URI=<sua conexão MongoDB Atlas, com senha renovada>
JWT_SECRET=<segredo aleatório de pelo menos 32 caracteres>
APP_ORIGIN=https://frontend-moto-pro.vercel.app
MP_BILLING_ENABLED=false
MP_ENFORCE_PREMIUM=false
MP_ACCESS_TOKEN=<token de testes do Mercado Pago>
MP_WEBHOOK_SECRET=<chave secreta de notificação>
MP_PUBLIC_ORIGIN=https://motopro-cc33b74592eb.herokuapp.com
```

Mantenha `MP_BILLING_ENABLED=false` até completar testes de sandbox/homologação, especialmente do checkout de crédito, validação das notificações e cancelamento. Uma URL de retorno ou o estado `authorized` do cartão **não** provam, isoladamente, que houve pagamento.

## Notificações Mercado Pago

Configure em suas integrações do Mercado Pago, para o ambiente adequado:

`https://motopro-cc33b74592eb.herokuapp.com/api/webhooks/mercadopago`

Eventos relevantes: `payment`, `subscription_preapproval`, `subscription_authorized_payment`.

O endpoint valida `x-signature` com HMAC e depois consulta a API do Mercado Pago para conciliação. Registros desconhecidos são ignorados. Requer testes com as modalidades disponíveis na conta do recebedor.

## Implantação

1. Substitua os arquivos do repositório **backend-MotoPRO**, mantendo `package.json` na raiz.
2. Faça o deploy no Heroku e confira `npm run build` e o endpoint `/api/health`.
3. Substitua os arquivos do repositório **frontend-MotoPRO**, mantenha `API_INTERNAL_URL` e faça o deploy na Vercel.
4. Entre no MotoPRO com usuário de teste. Em `/app/assinatura`, o sistema exibirá que os pagamentos estão **em homologação**.
5. Configure credenciais de teste, valide criação de Pix, notificação aprovada, renovação de cartão, expiração e cancelamento.
6. **Só depois**, com checkout restrito ao crédito e conformidade confirmados, considere habilitar `MP_BILLING_ENABLED=true`.
7. `MP_ENFORCE_PREMIUM=true` ativa a proteção do `/api/assistant` após o período de teste. Não ative antes de conferir faturamento e direitos do usuário.

## Admin

A rota `/app/admin` só funciona para usuário com `role='admin'` já autorizado. **Não** há endpoint público para tornar alguém administrador. A atribuição inicial deve ser feita pelo administrador do banco, após confirmar a titularidade da conta.

## Pontos que ainda exigem homologação

- O Pix Automático depende de disponibilização efetiva do recurso para recebimento pelo Mercado Pago; **não foi implementado**. O Pix avulso está preparado.
- O checkout de cartão `preapproval` precisa ser testado e restringido a crédito pelo provedor. A tela do MotoPRO não exibe débito.
- Conciliação de faturamento de cartão, chargebacks, reembolso e datas de acesso exigem testes de ponta a ponta antes da produção.
- Sorteios promocionais: só devem ser anunciados/executados após orientação jurídica, autorização aplicável e regulamento. Não existe funcionalidade de participação ou seleção nesta versão.

## Segurança

As senhas e a JWT compartilhadas em conversas anteriores devem ser trocadas. Nenhuma credencial real foi incluída neste pacote. Não coloque `MP_ACCESS_TOKEN` no frontend ou em variáveis `NEXT_PUBLIC_*`.
