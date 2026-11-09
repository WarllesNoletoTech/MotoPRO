# MotoPRO V3.14.2 — Registro de abastecimentos em Minha moto

Base: MotoPRO V3.14.1 com landing responsiva, nome/sobrenome obrigatório, Pix Premium e integração Rappidex.

## Alteração

Na página **Minha moto** há um formulário **Registrar abastecimento** com valor e data obrigatórios, tipo de combustível, litros, quilometragem e posto opcionais. Há também um histórico com 30 registros mais recentes e indicadores de gasto, litros e número de abastecimentos no mês.

## Financeiro sem lançamentos duplicados

Ao salvar o abastecimento, o frontend chama a rota já existente `POST /api/entries` com `type=expense` e `category=fuel`. Portanto o valor entra uma única vez na base de despesas e no resumo financeiro. Abastecimentos anteriores registrados em Lançamentos ou pelo assistente de voz também aparecem na lista. Apagar um abastecimento manual de Minha moto exclui o mesmo registro do Financeiro.

A rota `GET /api/moto/fuel` lista abastecimentos e retorna o resumo do mês, calculado no backend. Está protegida por autenticação e Premium, como as demais rotas de Minha moto.

## Arquivos alterados

- `frontend-MotoPRO/app/(protected)/app/moto/page.tsx`
- `frontend-MotoPRO/app/globals.css`
- `backend-MotoPRO/src/routes/moto.ts`
- `backend-MotoPRO/src/routes/entries.ts`
- `backend-MotoPRO/src/models/Entry.ts`
- `backend-MotoPRO/src/routes/account.ts`

## Deploy

1. Faça backup do código implantado.
2. Publique o backend `backend-MotoPRO` no Heroku (o modelo de lançamentos e nova rota são necessários).
3. Confirme build e API, depois publique `frontend-MotoPRO` na Vercel.
4. Teste com uma conta Premium: salve R$ 35,50 / 5,25 L e confirme que aparece em Minha moto e como **uma** despesa Combustível no Financeiro.
5. Exclua esse registro e confirme que desaparece dos dois lugares e que o total mensal diminui exatamente R$ 35,50.
6. Confira o comportamento no celular e a exportação CSV.

**Não é necessário mudar as variáveis do Mercado Pago, do Rappidex ou o valor da assinatura.**

## Limites

- A lista exibe os 30 abastecimentos mais recentes; o resumo mensal considera todos os registros do mês.
- Informar a quilometragem do abastecimento registra o KM daquele momento, mas não altera automaticamente a quilometragem atual cadastrada da moto.
- Por segurança, o registro é validado no servidor. Valores e quantidades inválidos não são aceitos.

## Verificações executadas

- Validação de sintaxe TS/TSX com compilador TypeScript (transpile), 77 arquivos sem erros.
- Checagem estática de fluxo de registro único, resumo e restrição Premium.
- **A compilação completa com as dependências npm e o teste conectado ao MongoDB não foram executados neste ambiente.** Validar no Heroku/Vercel antes de liberar aos demais usuários.
