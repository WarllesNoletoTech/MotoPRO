# MotoPRO – Indicações (R$ 5) e WhatsApp no painel administrativo

## Funcionalidades incluídas

- Cada motoboy possui um código exclusivo, inclusive usuários antigos ao abrir **Indique e ganhe**.
- Compartilhamento por WhatsApp e link de cadastro com `?ref=CODIGO`. O código pode ser digitado no cadastro.
- O vínculo de indicação é definido no cadastro, não pode ser alterado posteriormente. Indicação não é retroativa.
- Ao receber o **primeiro pagamento aprovado e conciliado diretamente no Mercado Pago**, o sistema registra R$ 5 em favor de quem indicou.
- **Um bônus por indicado**, protegido por índice exclusivo no MongoDB, mesmo se o webhook chegar duplicado.
- Se o primeiro pagamento Pix for estornado antes do repasse, a indicação é revertida. Se já houve repasse, é necessária conciliação manual.
- Área `Indique e ganhe` exibe link, quantidade, indicações aguardando pagamento, valor disponível e valor já repassado, mesmo quando o Premium está vencido.
- Admin > **Indicações**: saldo disponível, repasses efetuados, estornos e marcação de repasse já feito com observação em auditoria.
- Admin > **Motoboys**: número brasileiro abre conversa no WhatsApp diretamente.

## Atenção ao repasse

O MotoPRO **não transfere os R$ 5 automaticamente**, não desconta do plano Premium e não gera Pix de pagamento ao indicador. O valor é contabilizado como **a pagar pelo administrador**. Efetue o pagamento externo, confirme com o beneficiário e só depois marque como pago no painel. Não marca a cobrança do indicado como aprovada: apenas o Mercado Pago pode fazer isso.

## Publicação

1. Faça deploy do **backend-MotoPRO** (Heroku, MongoDB e variáveis atuais) primeiro.
2. Faça deploy do **frontend-MotoPRO** (Vercel) depois.
3. Entre como motoboy, acesse **Indique e ganhe**, copie o link, crie uma conta nova com telefone diferente e faça um pagamento real confirmado. Valide um único bônus de R$ 5 no admin.
4. Repita a notificação do Mercado Pago/atualização da cobrança e confirme que não duplica o bônus.
5. Confirme que o link do celular abre o WhatsApp no painel administrativo e que marcar um repasse como pago aparece para o motoboy.

Os novos índices MongoDB são declarados nos modelos (`User.referralCode` e `ReferralReward.referredUserId`). Em bases com configuração `autoIndex: false`, crie-os durante a migração antes de ativar o recurso.
