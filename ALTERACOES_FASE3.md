# MotoPRO v1.5.0 — Entrega da Fase 3

## Entregas particulares
- Modelo `PrivateCustomer` de clientes próprios, com telefone opcional, anotação, filtro por nome e paginação; edição e arquivamento.
- Exclusão de cliente sem histórico. Em clientes com histórico, remoção dos dados pessoais (anonimização) preservando lançamentos financeiros.
- Modelo `PrivateDelivery` de entregas, com cliente opcional, data e valor.
- Entrega pendente não é ganho. Ao confirmar recebimento, cria-se uma receita em `Entry` com índice único e bloqueio de alteração durante a confirmação. Solicitações repetidas não duplicam receitas. A data da receita é a data da confirmação do pagamento (regime de caixa); a data original da entrega é preservada no histórico.
- Relatório CSV e impressão para PDF no próprio navegador.

## Financeiro e origens
- Seleção opcional de plataforma para receitas manuais: Rappidex, iFood, Uber, 99 e outras.
- Importações existentes do Rappidex continuam identificadas pela integração.
- Relatório de receitas brutas por plataforma, despesas gerais, saldo estimado agregado e evolução mensal; filtros de até 366 dias.
- Conciliação Rappidex ignora receitas provenientes de entregas particulares.

## Conquistas e administração
- Conquistas pessoais objetivas com progresso e regras visíveis: registros, metas, moto, manutenção, integração e entregas particulares.
- Campanhas continuam sujeitas a critérios objetivos e aprovação pelo administrador, sem sorteios automáticos.
- Nova aba Admin > Indicadores com período 7/30/90 dias: usuários ativos, novos, retenção de coorte, assinaturas pagas/cortesias, pagamentos aprovados, projeção teórica mensal, adesão a entregas particulares e métricas de IA.
- Exportação CSV, impressão para PDF e consulta individual auditada com quantidades de clientes e entregas.

## Testes e limites
- `npm run typecheck`, `npm test` (backend) e `npm run build` executados em ambiente local com Node.js 22; os projetos declaram Node.js 24 no deploy.
- **Não** foi validada conexão ao MongoDB de produção, Mercado Pago, Rappidex, e-mail, OpenAI ou instalação real PWA em Android.
- PDF é produzido pelo diálogo `Imprimir > Salvar como PDF`, sem gerador PDF no servidor.
- Ganhos identificados manualmente como iFood **não** são obtidos da API oficial do iFood.
- O pacote contém as fases anteriores e deve ser implantado primeiro no Heroku (backend) e depois na Vercel (frontend), após backup e homologação.
