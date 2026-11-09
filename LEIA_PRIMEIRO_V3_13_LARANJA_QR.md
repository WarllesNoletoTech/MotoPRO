# MotoPRO V3.13 — Preto e Laranja-âmbar + QR Code em destaque

## O que foi alterado
- Identidade visual verde do MotoPRO trocada por laranja/âmbar em todas as telas (incluindo o login, dashboard, administração, botões, menu, ícones e gráficos).
- Fundos continuam pretos/grafite. Verde reservado a confirmação real de Pix aprovado, sucesso e valores positivos.
- Ícones de instalação PWA de 192px e 512px atualizados para a nova cor.
- No formulário Assinatura, após clicar em Gerar Pix, o QR Code aparece imediatamente abaixo da ação, acima das mensagens secundárias.
- A página rola automaticamente até o QR Code recém-gerado e apresenta o botão Copiar Pix.
- Uma cobrança Pix pendente válida é destacada também ao reabrir a página, sem que o usuário tenha que procurar.
- Não houve alterações em backend, autenticação, banco, preços, vencimento ou integração Mercado Pago.

## Implantação
1. Esta atualização é somente de frontend: publique `frontend-MotoPRO/` na Vercel, sem modificar o backend Heroku.
2. Faça um refresh completo e teste o botão Gerar Pix e a cópia do código.
3. Confirme que status **Pagamento confirmado!** continua verde; estados de espera usam âmbar.
4. Teste a instalação como PWA, para atualizar os ícones e eventuais caches do navegador.

## Nota sobre os testes
Foi feita verificação de sintaxe TypeScript/TSX, inspeção estrutural do JSX do Pix e checagem dos arquivos ZIP.
O build integral depende das bibliotecas de produção e deve ser validado na Vercel antes de entrar em uso.
