# MotoPRO V3.11 — Celular obrigatório + convite de instalação

## Cadastro e contas antigas
- Cadastro de motoboy exige celular brasileiro válido com DDD. O backend salva no formato E.164 (`+55DDD9XXXXXXXX`).
- Contas antigas sem celular: na próxima autenticação/abertura do app, antes de usar módulos internos, aparece o formulário **Falta só seu número de celular**. O usuário envia o número pelo endpoint autenticado `PATCH /api/auth/phone`.
- O bloqueio também existe no backend para as rotas operacionais, inclusive quando o Premium estiver temporariamente desativado, para que não dependa somente da interface.
- Administração pode ver se o motoboy já informou o número. Usuário pode atualizar o número em Configurações.
- E-mail, login, senha, Pix, assinatura semanal, trial do admin e dados existentes não são apagados.

## Instalação como PWA
- Na primeira entrada em `/app`, exibe convite de instalação em Android/iOS elegíveis, salvo se o usuário já instalou ou adiou o convite recentemente.
- Chrome/Edge compatíveis: botão usa `beforeinstallprompt` quando o navegador disponibilizar o evento e requer o toque do usuário.
- iPhone: instruções **Compartilhar → Adicionar à Tela de Início**; não é possível forçar o diálogo nativo no iOS.
- Se o navegador ainda não disponibilizar a instalação, mostra instruções em vez de simular sucesso.
- Após clicar **Agora não**, o convite não volta por 7 dias no mesmo navegador, conforme armazenamento local.
- PWA usa `manifest.webmanifest`, ícones, modo `standalone` e service worker já presentes no projeto.

## Implantação
1. Envie o conteúdo do ZIP de backend ao repositório `backend-MotoPRO` e faça o deploy no Heroku.
2. Em seguida envie o frontend à Vercel.
3. Faça login com uma conta antiga sem celular; confirme o formulário obrigatório.
4. Crie uma conta nova: cadastro deve exigir celular brasileiro com DDD.
5. Em Android Chrome sem app instalado, entre em `/app`: deve surgir o convite para instalar. Teste também após instalação e em iPhone.
6. Confira que Pix, validação Premium e painel administrativo não regrediram.

Não altere credenciais Mercado Pago. Não substitua o banco. Nada foi publicado automaticamente.
