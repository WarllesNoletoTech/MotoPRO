# MotoPRO 1.5.0 — Checklist de homologação da Fase 3

## Alterações técnicas

- **Backend**: `GET/POST/PATCH/DELETE /api/particulares/customers`, `GET/POST/PATCH/DELETE /api/particulares/deliveries`, `POST /api/particulares/deliveries/:id/confirm-payment` e `GET /api/particulares/deliveries/export`.
- **Comparativo**: `GET /api/plataformas?from=AAAA-MM-DD&to=AAAA-MM-DD` (máx. 366 dias) e seletor opcional de plataforma no lançamento manual de receita.
- **Conquistas**: `GET /api/conquistas`, com métricas pessoais calculadas a partir dos dados atuais; benefícios dependem do regulamento das campanhas publicadas.
- **Admin**: `GET /api/admin/billing/analytics?days=7|30|90` (herda o middleware de administrador) e contadores de clientes/entregas na consulta auditada de motoboy.
- **Financeiro**: cada confirmação de recebimento particular gera **no máximo uma** receita no modelo `Entry` (`source='private'`, `provider='private'`, `externalId=idDaEntrega`) com índice exclusivo; recebimentos pendentes não contam na receita, e a tela de conciliação Rappidex ignora receitas particulares.
- **Dados**: a exportação de conta inclui clientes particulares, entregas e identificação de plataforma nas receitas.

## Comandos (executar em cada pasta)

```bash
npm ci
npm run typecheck
npm test    # somente backend
npm run build
```

Node.js esperado nos deploys: **24.x** (configurado nos `package.json`).

## Testes funcionais — motoboy

- [ ] Cadastro, login, sessão e acesso Premium mantidos.
- [ ] Criar cliente particular com nome/telefone; editar; pesquisar por nome; arquivar e reativar.
- [ ] Excluir cliente com histórico: contato e observações devem ser anonimizados; histórico financeiro deve permanecer. Cliente sem histórico pode ser excluído definitivamente.
- [ ] Criar entrega **pendente**; conferir que o dashboard e os relatórios **não somaram** seu valor.
- [ ] Editar e excluir entrega pendente, respeitando a conta do usuário autenticado.
- [ ] Confirmar pagamento de uma entrega e conferir **uma única receita** no Financeiro, dashboard e relatórios.
- [ ] Clicar em `Recebi` novamente (requisição repetida) e conferir ausência de duplicidade.
- [ ] Confirmar que a entrega já recebida não pode ser editada nem excluída pelo Financeiro.
- [ ] Testar dois usuários distintos: nunca acessar clientes ou entregas uns dos outros.
- [ ] Testar arquivo CSV de entregas e PDF via `Imprimir` -> `Salvar como PDF`.
- [ ] Registrar ganho manual com plataforma iFood (sem integração); conferir comparativo.
- [ ] Importar Rappidex e conferir que origem fica identificada como importação real.
- [ ] Verificar ganhos por plataforma, despesas totais e aviso de que lucro **não** está alocado individualmente por aplicativo.
- [ ] Ver conquistas desbloqueadas por dados reais e campanhas publicadas, sem sorteio.
- [ ] Confirmar relatório semanal, envio por e-mail (se configurado) e alertas de manutenção.

## Testes funcionais — administrador

- [ ] `Admin > Indicadores`: alternar 7, 30 e 90 dias, conferir métricas e notas de cálculo.
- [ ] CSV de indicadores e opção de impressão para salvar PDF.
- [ ] Conferir assinaturas ativas e cortesias separadas; receita aprovada por pagamentos reais.
- [ ] Conferir que projeção mensal é **indicativa**, não receita efetivamente cobrada.
- [ ] Ver último acesso e quantidades de clientes e entregas no detalhe auditado de motoboy.
- [ ] Usuário comum não pode acessar `/api/admin/billing/analytics`.

## Integrações e produção

- [ ] Preservar variáveis de Mercado Pago e verificar Pix aprovado, renovação, webhooks e estorno.
- [ ] Preservar Rappidex e verificar sincronização, idempotência e conciliação.
- [ ] Configurar OpenAI apenas se usar scanner e voz; acompanhar custos no admin.
- [ ] Configurar serviço de e-mail (`RESEND_API_KEY`, `REPORTS_FROM_EMAIL`) e Heroku Scheduler se usar envio automático.
- [ ] Verificar responsividade Android/PWA e ausência da barra de endereço na instalação standalone.
- [ ] Atualizar a política de privacidade para dados de clientes particulares e permitir exportação de dados; revisar LGPD antes de produção.
- [ ] Fazer backup e homologar em **ambiente separado** antes de alterar a produção.

**Limites**: estes itens são um checklist de testes de homologação. A compilação automatizada **não confirma** integração real com Mercado Pago, iFood, Rappidex, OpenAI, envio de e-mails, compatibilidade de banco de dados existente nem funcionamento da instalação PWA em modelos específicos de Android.
