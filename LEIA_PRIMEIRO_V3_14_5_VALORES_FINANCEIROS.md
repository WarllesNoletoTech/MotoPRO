# MotoPRO V3.14.5 — Reconhecimento de valores monetários

## O que foi corrigido

A IA já entende a intenção do comando, mas a versão anterior tinha um segundo interpretador de valores que rejeitava expressões como "25 mil". O parser e a validação foram alinhados para reconhecer os mesmos formatos financeiros sem aceitar valores inventados pela IA.

- `backend-MotoPRO/src/services/commands.ts`: leitura de valores em reais e centavos, unidades por extenso, multiplicadores (`mil`, `k`, `milhão`), pontuação brasileira (1.000 / 1.250,50) e frases informais.
- `backend-MotoPRO/src/services/aiCommands.ts`: a IA continua classificando a intenção e a categoria, mas o valor deve ser confirmado no texto enviado. Ajustados exemplos para milhares e simplificada a verificação de quantidade física. O cadastro não é salvo sem confirmação.
- `backend-MotoPRO/src/routes/assistant.ts`: contexto de transcrição com valores grandes para português brasileiro.
- Arquivos de teste em `backend-MotoPRO/src/services` expandidos.

## Exemplos confirmados em testes isolados

| Frase | Valor reconhecido |
|---|---:|
| Ganhei mil reais | R$ 1.000,00 |
| Ganhei 1000 | R$ 1.000,00 |
| Recebi 1.000 | R$ 1.000,00 |
| Ganhei 25 mil | R$ 25.000,00 |
| Faturei vinte e cinco mil reais | R$ 25.000,00 |
| Recebi 1.250,50 | R$ 1.250,50 |
| Ganhei mil e quinhentos | R$ 1.500,00 |
| Paguei mil reais e cinquenta centavos | R$ 1.000,50 |
| Recebi trinta e cinco centavos | R$ 0,35 |
| Ganhei 25 mil e cinquenta centavos | R$ 25.000,50 |

`Ganhei 5 entregas`, `Abasteci 8 litros` e `Rodei 30 km` não são convertidos em dinheiro.

## Publicação

1. Atualize somente o backend MotoPRO no GitHub/Heroku com este pacote.
2. O frontend da V3.14.4 está incluído, mas não sofreu modificações nesta atualização. Não é necessário redeploy na Vercel se já está na V3.14.4.
3. Não altere `OPENAI_API_KEY` ou o Pix. Não são necessárias novas variáveis.
4. Teste os exemplos com o assistente (voz e texto), confirme o valor exibido e só então autorize o lançamento.

## Validações e limitações

- 7 grupos de testes isolados passaram, incluindo os casos financeiros adicionados.
- 81 arquivos TS/TSX verificados sem erros de **sintaxe**.
- `commands.ts` passou na verificação de tipos isolada.
- O build completo do projeto com todas as dependências e a comunicação ao vivo com a OpenAI **não foram executados** neste ambiente: confirme o deploy no Heroku e valide as transcrições no celular.

## Segurança

- A IA não registra automaticamente receitas nem despesas; o usuário continua confirmando antes de salvar.
- Valores não comprovados pelo texto permanecem bloqueados para revisão.
- O Pix semanal de R$ 9,99, assinatura Premium, Rappidex, abastecimentos e interface visual não foram alterados.
