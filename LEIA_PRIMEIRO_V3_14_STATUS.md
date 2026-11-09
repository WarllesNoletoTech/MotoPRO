# MotoPRO V3.14 — Cores dos status financeiros

**Alteração somente no frontend Vercel.** O backend da V3.13 foi preservado.

- Aprovado / pago / ativo: **verde**.
- Pendente / aguardando pagamento / em processamento / vence em breve: **amarelo**.
- Cancelado / recusado / estornado / vencido: **vermelho**.
- Outros status não reconhecidos: neutro, evitando exibir falsa aprovação.

Aplicado à aba Administração > Financeiro, Administração > Assinaturas,
à confirmação e ao aguardando Pix, e aos estados de assinatura.
A identidade preta com laranja-âmbar e o QR Code destacado permanecem intactos.

## Publicar
Envie somente o conteúdo da pasta `frontend-MotoPRO` para o repositório da Vercel,
aguarde o deploy e atualize a página (`Ctrl + Shift + R`). Não precisa alterar o Heroku.

## Teste
Confira uma linha aprovada (verde), outra cancelada (vermelho),
e outra pendente (amarelo) em Administração > Financeiro.
O status é sempre o que veio da API; a mudança afeta apenas a apresentação.
