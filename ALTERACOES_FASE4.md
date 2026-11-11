# Alterações — Fase 4 (MotoPRO 1.6.0)

## Backend
- `src/models/RecurringExpense.ts`: nova coleção de despesas mensais, com usuário, categoria, valor, dia e status.
- `src/services/recurringExpenses.ts`: criação idempotente por competência mensal; sem retroatividade.
- `src/services/recurringDates.ts`: validação e cálculo de dias 29/30/31, virada de mês e de ano.
- `src/routes/recurringExpenses.ts`: API para listar, criar, editar, ativar/pausar, excluir e sincronizar.
- `src/models/Entry.ts`: origem `recurring`, vínculo e índice único por regra+competência.
- `src/routes/entries.ts`: impede criação manual da origem recorrente e bloqueia exclusão que geraria duplicidade; mantém edição segura.
- `src/routes/alerts.ts`: avisos consolidados de manutenção, recebimentos pendentes e despesas recorrentes.
- `src/routes/productivity.ts`: indicadores pessoais por mês, receitas, despesas, comparação e médias.
- `src/routes/adminInsights.ts`: adoção agregada de despesas recorrentes no painel administrativo.
- `src/routes/account.ts`: exportação pessoal inclui as novas regras mensais.
- `src/index.ts`: novas rotas exigem autenticação e Premium; índice inicializado na abertura do servidor.
- `src/services/phase4.test.ts`: novos testes de datas; `premiumRoutes.test.ts` cobre as rotas.

## Frontend
- `/app/recorrentes`: CRUD de despesas recorrentes, status e sincronização manual.
- `/app/avisos`: central interna de pendências com acesso às páginas relevantes.
- `/app/produtividade`: comparativos, médias e receita por dia.
- Sidebar e atalhos no dashboard; sincronização mensal ao acessar app com Premium.
- Admin: indicadores agregados de adoção de recorrências; CSS responsivo.

## Compatibilidade e limites
- Fases 1, 2 e 3 mantidas. Nenhuma alteração em tokens/cobranças de Mercado Pago.
- Os avisos são internos: não há push, SMS ou WhatsApp automático.
- Os lançamentos recorrentes representam despesas cadastradas para controle; não pagamentos executados.
- A sincronização não roda enquanto ninguém abre o aplicativo. É intencional para evitar tarefas em segundo plano sem consentimento.
- Testes de compilação e funções puras foram executados; falta homologação ponta a ponta com banco e fornecedores reais.
