# Frontend MotoPRO

Aplicativo Next.js + TypeScript + PWA, independente do backend.

1. Instale Node.js 22+.
2. Execute `npm install` nesta pasta.
3. Copie `.env.example` para `.env.local`.
4. Configure `API_INTERNAL_URL=http://localhost:4000` para desenvolvimento local.
5. Rode `npm run dev` e abra `http://localhost:3000`.

A configuração do Next.js encaminha `/api/*` para a API definida em `API_INTERNAL_URL`. Na Vercel, configure `API_INTERNAL_URL` com a URL HTTPS da API publicada no Heroku.
