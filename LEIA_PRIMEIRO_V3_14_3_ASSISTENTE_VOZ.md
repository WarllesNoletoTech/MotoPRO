# MotoPRO V3.14.3 — Assistente de voz

## O que mudou

- Gravação de até **10 segundos**: botão para parar antes, contador regressivo e parada automática.
- Duração informada ao backend e rejeição quando excede o limite com pequena tolerância para atrasos do navegador.
- Contexto de transcrição em português brasileiro direcionado ao vocabulário dos entregadores (ganhos, combustível, Pix, manutenção, etc.), sem alterar o modelo configurado.
- Transcrição exibida imediatamente **abaixo do microfone**, com campo editável e botão de reinterpretar.
- Resultado da interpretação (ou aviso de que não foi possível entender) exibido **no mesmo painel do microfone**.
- Interpretação melhorada para valores por extenso, quantidades de litros seguidas de valores monetários, despesas com combustível e consultas de saldo.
- Após edição da transcrição, a interpretação anterior é invalidada. **Nada é salvo sem o toque em Confirmar e salvar**.

## Publicação

1. Publique `backend-MotoPRO` no Heroku do MotoPRO.
2. Publique `frontend-MotoPRO` na Vercel do MotoPRO.
3. Verifique no Heroku `OPENAI_API_KEY` e, se desejar, `OPENAI_TRANSCRIPTION_MODEL` (o padrão continua `gpt-4o-mini-transcribe`). Não coloque segredo na Vercel.
4. Teste em Chrome Android e navegador do computador, dando permissão de microfone.
5. Verifique os exemplos: "Abasteci 35 reais", "Abasteci oito litros, paguei 40 reais", "Ganhei cento e vinte reais", "Quanto lucrei esta semana?".
6. Revise o valor e a categoria antes de confirmar o lançamento.

## Preservado

Mercado Pago Pix de R$ 9,99, assinaturas, Premium, cadastro completo, integração Rappidex, Minha moto/abastecimentos e landing responsiva.

## Observações de validação

O interpretador foi testado localmente com frases representativas; os arquivos TS/TSX foram submetidos à validação de sintaxe. O `npm ci --offline` não terminou porque o cache não contém todas as dependências. **Não foi possível realizar build completo nem teste real com áudio/API OpenAI nesta sessão**. Confirme a compilação no Heroku e na Vercel antes de liberar o recurso amplamente.

A duração recebida do navegador é validada para o fluxo normal. Essa verificação não substitui análise da duração do áudio em servidor para clientes adulterados.
