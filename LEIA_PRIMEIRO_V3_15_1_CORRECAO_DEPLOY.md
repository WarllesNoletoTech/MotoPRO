# MotoPRO V3.15.1 — correção do build Vercel

## O que foi corrigido
- Corrigido o erro `Cannot find name 'confirmPayout'` em `frontend-MotoPRO/app/(protected)/app/admin/page.tsx`.
- Adicionada a função de confirmação de repasse do bônus por indicação.
- A função exige observação de pelo menos 4 caracteres, chama `POST /admin/billing/referrals/:id/mark-paid`, atualiza a lista e informa resultado.
- Em caso de falha na API, preserva o modal para tentar novamente.

## Publicação
1. Atualize o repositório GitHub do frontend com os arquivos de `frontend-MotoPRO`.
2. Faça um novo deploy no Vercel.
3. Para a funcionalidade de indicações, mantenha também o backend da V3.15 publicado no Heroku.

## Validação
- Sintaxe TSX do arquivo alterado validada via transpileModule do TypeScript (sem diagnósticos de sintaxe).
- Não foi possível executar `next build`/typecheck completo neste ambiente porque a instalação das dependências não concluiu.
- A rota consumida foi conferida no código do backend incluído no ZIP.
