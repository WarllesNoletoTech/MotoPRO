# MotoPRO — Fase 4 — Checklist de homologação

## Situação do pacote
- Versão: **1.6.0**. Fases anteriores preservadas.
- **87 testes automatizados** de backend aprovados, backend typecheck/build e frontend typecheck/build aprovados.
- Build local não comprova funcionamento com MongoDB real, navegador Android ou APIs externas.
- Implante em **homologação** antes de produção; backend primeiro.

## 1. Despesas recorrentes (com uma conta motoboy de teste)
- [ ] Criar uma regra para um dia que ainda não chegou neste mês; nenhum lançamento financeiro deve surgir antes do vencimento.
- [ ] Criar regra com dia igual ou anterior ao de hoje; `POST /api/recorrentes/sync` deve registrar exatamente um lançamento.
- [ ] Apertar **Conferir agora** repetidas vezes e abrir duas abas: o total não deve aumentar.
- [ ] Na edição, mudar valor e dia após a competência ter sido registrada: não pode criar segundo lançamento para a mesma regra/mês.
- [ ] Pausar, reativar e excluir regras: registros já criados permanecem no histórico.
- [ ] Conferir regra do dia 31 em fevereiro e meses de 30 dias.
- [ ] Conferir exceções de assinatura Premium vencida: as novas rotas são bloqueadas.
- [ ] Conferir se não há geração retroativa de meses sem acesso.
- [ ] Validar visualmente a categoria e a origem 'recurring' nos lançamentos e exportação.
- [ ] Lançamentos recorrentes existentes podem ser corrigidos (PATCH), mas exclusão é bloqueada para evitar geração duplicada.

## 2. Central de avisos
- [ ] Criar entrega particular pendente, verificar aviso e valor; confirmar pagamento e verificar se o aviso desaparece.
- [ ] Cadastrar manutenção futura dentro de 7 dias ou 500 km; verificar alerta correspondente.
- [ ] Regra mensal com vencimento nos próximos 7 dias deve aparecer; após contabilizada, não deve indicar vencimento duplicado no mês.
- [ ] Testar navegação pelos avisos e o layout em celular.
- [ ] Confirmar que não há push ou mensagens automáticas: avisos são exibidos apenas no app.

## 3. Produtividade
- [ ] Conferir receitas e despesas contra lançamentos reais de cada mês.
- [ ] Comparar mês atual (parcial) e mês anterior (completo), com ressalva de períodos diferentes.
- [ ] Conferir categorias e médias, sem tratar lote importado como entrega individual.
- [ ] Testar meses sem registros, períodos futuros e limites do histórico.

## 4. Administração
- [ ] Verificar contagem de regras ativas e novas despesas recorrentes nos últimos 7 dias.
- [ ] Verificar que administradores não recebem credenciais, tokens ou dados financeiros individuais nessas métricas.

## 5. Regressão obrigatória de fases 1–3
- [ ] Login/logout e bloqueio/ativação Premium.
- [ ] QR Pix, webhooks e renovação Mercado Pago reais, sem cobrança duplicada.
- [ ] Rappidex: vínculo, sincronização, importação e conciliação.
- [ ] IA de voz e leitura de comprovantes com confirmação.
- [ ] Envio semanal por e-mail, se Resend e Scheduler configurados.
- [ ] Entregas particulares: cadastrar, confirmar, editar e exportar.
- [ ] PWA Android, favicon, ícones, instalação e navegação responsiva.
- [ ] Backup e plano de reversão se índice MongoDB não puder ser criado.

## 6. Infraestrutura
- `API_INTERNAL_URL`: URL HTTPS real do Heroku, sem `/api`, definida na Vercel.
- `APP_ORIGIN`: domínio HTTPS exato da Vercel no Heroku.
- Node.js **24.x** nos dois projetos.
- Credenciais OpenAI/Mercado Pago/Rappidex/Resend preservadas apenas como variáveis privadas.

**Nota:** as despesas recorrentes são lançamentos de controle financeiro do usuário, não cobranças reais, boletos, pagamentos ou débitos automáticos. Não existe scheduler obrigatório para a Fase 4; os lançamentos são processados quando o usuário acessa o aplicativo.
