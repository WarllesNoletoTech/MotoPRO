# MotoPRO V3.14.4 — interpretação de comandos por IA

## Alterações
- Mantém gravação com limite automático de 10 segundos, transcrição visível junto ao microfone e revisão antes de salvar.
- No backend, a rota `/api/assistant/interpret` usa a OpenAI Responses API com saída estruturada para entender linguagem natural em português brasileiro.
- O resultado reconhece lançamentos de receita, despesa ou consulta de resumo. A IA não acessa o banco nem realiza lançamentos: ela só devolve dados estruturados, validados pelo servidor.
- Valida o valor inferido contra o texto transcrito. Se não houver valor claro ou a IA tentar inventar um preço, exige correção antes de salvar.
- Detecta alguns casos de confusão entre receita e despesa e evita tratar quilômetros, litros e número de corridas como reais.
- Quando a API de IA estiver indisponível ou sem permissão, retorna ao interpretador básico **com aviso explícito na interface**, não finge usar IA.
- Adiciona identificação visual "Interpretado pela IA" ou "Interpretação básica".
- Aumenta a qualidade da transcrição padrão para `gpt-4o-transcribe` (pode ser substituído por variável de ambiente). Este modelo tem custo maior do que o mini.

## Configurar OpenAI (Heroku → motopro → Settings → Config Vars)
1. Manter `OPENAI_API_KEY`: chave privada existente.
2. **Na chave da OpenAI**, além de `Model capabilities → Audio: Request`, habilitar **`Model capabilities → Responses: Request`**. A chave antiga foi configurada somente para áudio; sem essa permissão o sistema usa interpretação básica.
3. `OPENAI_COMMAND_MODEL=gpt-4o-mini` (opcional; é o padrão para a nova interpretação estruturada).
4. `OPENAI_TRANSCRIPTION_MODEL=gpt-4o-transcribe` (recomendado para testar maior precisão; caso a variável esteja definida como `gpt-4o-mini-transcribe`, ela continuará no mini até ser alterada).
5. Não compartilhar nem colocar a chave na Vercel. A API é paga por uso; transcrição e interpretação consomem créditos separadamente. Monitore os custos no painel da OpenAI.

## Deploy
- Atualize o **backend no Heroku** e o **frontend na Vercel** a partir deste ZIP.
- Não é necessário modificar o Rappidex. O Pix, assinatura de R$ 9,99 e bloqueio Premium permanecem sem alterações.
- O modelo e a credencial de produção não podem ser exercitados no pacote local; faça o teste integrado somente com sua chave segura configurada no Heroku.

## Homologação
- Gravar "Coloquei cinquenta de gasolina". Deve surgir a transcrição (editável), etiqueta "Interpretado pela IA", despesa de R$ 50,00 e botão de confirmar.
- Gravar "Ganhei cento e vinte em entregas". Deve surgir receita de R$ 120,00.
- Gravar "Quanto lucrei esta semana?". Deve consultar o resumo no backend.
- Falar "Rodei 30 quilômetros". Não deve inventar despesa de R$ 30,00.
- Conferir o valor sempre antes de clicar em Confirmar. O áudio em si não é salvo.
- Caso apareça "Interpretação básica", verificar a permissão `Responses → Request`, créditos e logs do Heroku.

## Segurança
Nenhum comando é salvo automaticamente. O texto da fala é enviado ao provedor de IA para classificação apenas quando existe chave configurada, com `store:false`. Não há envio de senhas, tokens ou dados completos do usuário para o modelo. Evite falar informações pessoais no comando. 

## Verificações locais
Foi feita verificação de sintaxe de arquivos TypeScript/TSX e testes isolados de validação de valores. A instalação das dependências npm neste ambiente não foi concluída, portanto o build final de Heroku e Vercel deve ser conferido após o deploy. Não foi realizado teste de transcrição real usando a sua API.
