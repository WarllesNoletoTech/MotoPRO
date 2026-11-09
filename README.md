# MotoPRO V3.2 — Painel Administrativo completo

Aplicação separada: `backend-MotoPRO` (Heroku) e `frontend-MotoPRO` (Vercel).

## Leia primeiro

Abra `LEIA_PRIMEIRO_V3_2.md`, que descreve funcionalidades, segurança e limites da homologação.

## Início (Windows / desenvolvimento)

Configure `backend-MotoPRO/.env` a partir de `.env.example` e `frontend-MotoPRO/.env.local` a partir de `.env.example`.

```
cd backend-MotoPRO
npm install
npm run build
npm run dev
```

Em outro terminal:

```
cd frontend-MotoPRO
npm install
npm run build
npm run dev
```

## Publicação

- Atualize o repositório `backend-MotoPRO` com arquivos da pasta homônima e publique no Heroku.
- Atualize o repositório `frontend-MotoPRO` com arquivos da pasta homônima e publique na Vercel.
- Mantenha a configuração `API_INTERNAL_URL` no frontend e `APP_ORIGIN` no backend.
- Use branch de homologação / deploy de prévia antes de substituir a produção.
- Não comite arquivos `.env`, chaves JWT, tokens do Mercado Pago ou senhas.
- Para a conta admin única, `ADMIN_EMAIL` no Heroku deve coincidir com a conta que tiver `role=admin` no banco correto. O script `npm run admin:create` no backend permite criar/promover o primeiro admin, mas não cria um segundo admin se já existir um.

## Verificação

A sintaxe de 52 arquivos TS/TSX foi verificada sem erros. O build completo depende da instalação das dependências e deve ser executado antes do deploy.
