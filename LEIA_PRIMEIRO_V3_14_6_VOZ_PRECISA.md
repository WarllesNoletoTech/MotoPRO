# MotoPRO V3.14.6 — Transcrição de voz revisável

## Mudanças
- Transcrição padrão: `gpt-transcribe`, com `languages[]=pt` e contexto/vocabulário de entregadores, sem exemplos numéricos que podem induzir erros.
- Gravação máxima de 10 segundos, como na versão anterior.
- O próprio motoboy pode ouvir o áudio antes de confirmar o financeiro.
- Se a transcrição vier errada, existe o botão “Tentar outra transcrição” com modelo alternativo `gpt-4o-transcribe` (consome créditos adicionais somente quando acionado).
- O sistema mostra as duas leituras se forem diferentes e permite editar manualmente.
- Nada é salvo sem confirmação; valor e tipo de operação são validados.

## Configuração no Heroku
- Mantenha `OPENAI_API_KEY` com permissões de Audio Request e Responses Write.
- Se já houver `OPENAI_TRANSCRIPTION_MODEL=gpt-4o-transcribe`, troque para **`gpt-transcribe`** para ativar o novo mecanismo principal. Caso contrário, pode deixar a variável ausente.
- Não altere Mercado Pago, Pix ou os segredos da integração Rappidex.

## Publicação
- Atualizar backend no Heroku e frontend na Vercel.
- Testar com celular em local silencioso, dizendo frases reais de no máximo 10 segundos, mantendo o microfone próximo.
- A leitura alternativa com o modelo legado é opcional; `gpt-4o-transcribe` está sujeito a descontinuação pela OpenAI em 2027.

## Observação
Este pacote altera somente a transcrição e o assistente. Não garante reconhecimento perfeito em local muito ruidoso.
