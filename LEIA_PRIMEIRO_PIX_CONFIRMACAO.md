# MotoPRO V3.5 — Confirmação automática e OK verde do Pix

## Novidade
- Exibe **Aguardando pagamento** e verifica automaticamente a cada aproximadamente 6–7 segundos, após uma primeira verificação em cerca de 4,5 segundos enquanto o Pix estiver pendente.
- A API do backend consulta o Mercado Pago; apenas pagamento validado como aprovado, com assinatura Premium ativa, mostra **Pagamento confirmado!** com ícone verde e validade do acesso.
- O QR Code deixa de aparecer assim que o pagamento é aprovado.
- A confirmação continua visível após atualizar a página, com base no MongoDB.
- Mantém a consulta manual como alternativa e não altera o preço ou as credenciais.
- Se o QR Code vencer, o usuário é orientado a gerar outro Pix.

## Publicação
1. Publique o conteúdo de `backend-MotoPRO` no repositório usado pelo Heroku.
2. Publique o conteúdo de `frontend-MotoPRO` no repositório usado pela Vercel.
3. Teste com credenciais e contas de homologação; não utilize um banco real para simulações.
4. Gere o Pix e aguarde a aprovação do Mercado Pago: a tela deve mudar automaticamente para um cartão verde com o OK.
5. Confirme que chamadas repetidas não acrescentam 7 dias para a mesma order.

O polling do frontend é um mecanismo de acompanhamento. Somente o backend, consultando a API do Mercado Pago e validando o pagamento, pode liberar o Premium.
