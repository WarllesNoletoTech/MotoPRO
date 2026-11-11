# MotoPRO v1.4.0 — Checklist de homologação da Fase 2

## Implantação segura
- [ ] Publicar backend em *staging* Heroku, conectado a MongoDB de teste; não substituir produção inicialmente.
- [ ] Configurar `OPENAI_API_KEY`, `OPENAI_RECEIPT_MODEL` (modelo de visão), `APP_ORIGIN`, `JWT_SECRET`, `MONGODB_URI`.
- [ ] Não colocar chave OpenAI nem segredos Mercado Pago em `NEXT_PUBLIC_*`.
- [ ] Publicar frontend no Vercel Preview com `API_INTERNAL_URL` apontando para o backend de teste.
- [ ] Testar `/api/health` pelo domínio do frontend.
- [ ] Executar `npm ci`, `npm run typecheck`, `npm test`, `npm run build` no backend e `npm ci`, `npm run typecheck`, `npm run build` no frontend.
- [ ] Conferir índices únicos de comprovantes e lançamentos (criados no bootstrap).

## Voz e custo
- [ ] Gravar frases de até 10 segundos com celular parado e transcrever.
- [ ] Ativar opção de segunda transcrição e observar maior consumo de API.
- [ ] Quando as leituras divergirem, exigir escolha ou correção antes de interpretar.
- [ ] Dizer valores "mil", "25 mil", "1.000", "25,50", litros e km; IA nunca deve inventar dinheiro ou salvar sem aprovação.
- [ ] Testar falha de chave OpenAI e modelos sem permissão, sem perder dados.
- [ ] Conferir contagens agregadas de uso de IA na aba Admin > Sistema.
- [ ] Validar custos reais contra fatura da OpenAI; valores do painel são apenas estimativas e requerem tarifas configuradas.

## Comprovantes com IA
- [ ] Enviar imagens JPG/PNG/WEBP de 4 MB ou menos (com dados fictícios).
- [ ] Rejeitar arquivo falso/maior que limite; avaliar mensagem de erro no Android.
- [ ] Conferir valor, tipo, data e categoria no formulário antes de confirmar.
- [ ] Enviar comprovante sem total legível: valor deve ser preenchido manualmente.
- [ ] Fotografar comprovante de R$ 25,50 e confirmar como despesa de combustível.
- [ ] Escanear a mesma foto duas vezes e confirmar repetidamente: um único lançamento.
- [ ] Editar/excluir lançamento de comprovante pela tela Lançamentos e conferir saldo.
- [ ] Verificar que fotos e transcrições não são armazenadas em MongoDB; sugestão/identificador do comprovante pode permanecer até 30 dias.
- [ ] Confirmar que um motoboy não lê nem confirma escaneamentos de outro.
- [ ] Exceder 12 análises/hora numa conta de testes; confirmar limitação.

## Minha Moto
- [ ] Cadastrar moto e quilometragem atual.
- [ ] Criar plano por km, por dias, por ambos; atualizar quilometragem e conferir estados "Em dia", "Próximo", "Vencido".
- [ ] Registrar manutenção realizada, ver novo prazo, desativar plano.
- [ ] Conferir que os lembretes antigos e o histórico de abastecimento continuam funcionando.
- [ ] Consultar o manual do fabricante para definir prazos: o MotoPRO não prescreve intervalos.

## Rappidex, financeiro e administração
- [ ] Vincular conta de teste ao Rappidex e sincronizar receitas via Integrações.
- [ ] Abrir Conciliação (máximo 31 dias), verificar diferenças manuais/importadas.
- [ ] Criar dois ganhos idênticos em uma data, um manual e um importado: sinalizar como possível duplicidade, sem apagar.
- [ ] Verificar que pedidos importados não são alterados por reconciliar.
- [ ] Conferir registros, metas, assinaturas e cortesias da Fase 1.
- [ ] Testar Pix Mercado Pago sandbox, webhooks reais assinados e renovação semanal sem expor chaves.
- [ ] Testar acesso Premium e isolamento dos dados por conta.
- [ ] Exportar dados pela Configurações e confirmar presença dos planos de manutenção, comprovantes e métricas do próprio usuário.

## Limites de homologação
**Não foram testadas transações reais** do Mercado Pago, importações reais do Rappidex ou chamadas pagas da OpenAI, pois dependem de configurações e credenciais externas. O build local não substitui teste ponta a ponta no ambiente de homologação.
