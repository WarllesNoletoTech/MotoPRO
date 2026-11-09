# MotoPRO — Responsividade da landing V3.14.1

## O que mudou

- Cabeçalho: **Cadastre-se** ao lado de **Entrar**, sem esconder o cadastro no celular.
- Celular (até 980px): hero em **uma coluna** (texto primeiro; demonstração abaixo).
- Telas até 600px: fontes, espaçamentos, botões, card de demonstração, benefícios e rodapé ajustados.
- Telas de até 380px: cabeçalho compacto e botões principais em coluna.
- Não há mais sobreposição horizontal do card de demonstração sobre o título no mobile.
- Todas as demais funcionalidades existentes foram preservadas: nome/sobrenome, assinatura Pix Mercado Pago e integração Rappidex.

## Arquivos alterados

- `frontend-MotoPRO/app/page.tsx`
- `frontend-MotoPRO/app/globals.css`

## Como publicar

1. Substitua a versão do projeto **frontend-MotoPRO** no seu repositório GitHub (mantenha a configuração de ambiente existente na Vercel).
2. Faça commit/push e acompanhe o build do projeto na Vercel. **Não é necessário redeploy do backend Heroku por esta alteração visual.**
3. Teste a página `/` no Chrome DevTools nas larguras 320, 360, 390, 486, 768 e 1280px; abra `/cadastro` e `/entrar` para validar os links.
4. Se estiver instalada como PWA ou cacheada pelo navegador, recarregue a página após o deploy.

## Atenção

O ZIP contém os fontes completos fornecidos anteriormente. Não inclui `.env` real e não substitui suas variáveis de ambiente. Builds completos precisam ser confirmados na Vercel e no Heroku antes de divulgar a nova versão.
