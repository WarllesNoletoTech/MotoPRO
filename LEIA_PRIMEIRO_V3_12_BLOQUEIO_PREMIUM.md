# MotoPRO V3.12 — Pente-fino Premium, teste grátis e cobrança Pix

## Correção da causa
- Um campo `premiumRequired=false` antigo no MongoDB liberava acesso aos recursos mesmo com 0 dias.
- O vencimento de teste estava gravado na conta; mudar os dias no admin não recalculava usuários existentes.
- O frontend podia reaproveitar acesso de uma página anterior e, no caso de backend defasado, confiava no campo `allowed`.

## Regras agora
- A exigência Premium é permanente para motoboys (não existe opção de desligar em Configurações); administrador não precisa pagar.
- Admin controla de 0 a 30 dias de teste gratuito. O prazo é calculado por `createdAt + trialDays` em TODA consulta (nenhuma atualização destrutiva no MongoDB).
- 0 dias: sem teste, bloqueio imediato para quem não tem Pix aprovado, prazo pago vigente ou cortesia individual válida.
- Ex.: mudou 0 para 1 dia: contas criadas há menos de 24 horas ganham direito até completar 24 horas desde a criação; contas mais antigas não recebem um dia novo.
- Reduzir o prazo pode bloquear quem estava em teste. Pagamentos e cortesias não são afetados.
- As APIs de dashboard, lançamentos, metas, moto, IA, integrações e campanhas são protegidas por requireAuth + requirePremium.
- Cadastro, telefone obrigatório, login, assinatura Pix e exportação dos próprios dados continuam acessíveis.
- Interface verifica a assinatura ao trocar de rota e a cada 25 segundos com a aba visível; mesmo um frontend adulterado não consegue usar APIs protegidas.
- Caso Heroku/Vercel estejam em versões distintas, o frontend bloqueia por segurança e orienta a verificar o backend.

## Deploy
1. Atualize o **backend Heroku** usando a pasta backend-MotoPRO deste ZIP. Confira se o build termina com sucesso.
2. Atualize o **frontend Vercel** usando frontend-MotoPRO. Confira o build.
3. Abra **Administração > Configurações** e salve `Dias gratuitos = 0` (o campo Premium obrigatório não possui botão de desligar).
4. Faça login com conta nova de motoboy sem pagamento: deverá mostrar a tela de bloqueio e o botão Gerar Pix; confirme que não acessa lançamentos, metas e assistente.
5. Altere de 0 para 1 dia: a mesma conta cadastrada há menos de um dia deverá mostrar teste ativo e acesso liberado. Volte para 0 e confirme bloqueio.
6. Faça Pix de homologação: após aprovação, a tela mostrará OK verde e os dados permanecerão intactos.
7. Confira uma conta paga antiga e uma conta do administrador.

## Observações
- Não precisa excluir contas, zerar banco, manipular pagamentos, trocar tokens ou alterar variáveis do Heroku.
- O modo Premium não depende mais de MP_ENFORCE_PREMIUM; a configuração antiga pode permanecer, mas não desbloqueia nada.
- O cartão continua desativado; Pix é renovação manual a cada 7 dias.
- A validação local abaixo não substitui teste real de integração com Heroku, MongoDB e Mercado Pago.
