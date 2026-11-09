# MotoPRO V3.10 — O administrador controla a exigência Premium

## Diagnóstico
O backend antigo permitia todos os recursos quando `MP_ENFORCE_PREMIUM=false` no Heroku, mesmo que o administrador tivesse definido `trialDays=0`.

## Correção
O painel `Administração > Configurações` tem o controle **Exigir assinatura Premium para usar todos os recursos**, salvo no MongoDB com auditoria. Começa **ativado** para instalações existentes que ainda não tenham essa opção. Essa configuração, não a variável antiga, comanda o middleware de proteção e o estado exibido ao motoboy.

- `Dias de teste para novos cadastros=0`: usuário novo não recebe acesso grátis.
- `Dias de teste=1..30`: usuário novo recebe essa quantidade de dias.
- A mudança de dias não expira testes já concedidos, cortesias nem assinaturas pagas.
- A regra de bloqueio é conferida no **servidor** a cada chamada a recurso Premium.
- Cadastro, login, pagamento Pix, consulta da assinatura e exportação de dados próprios continuam disponíveis.
- O administrador é isento. A opção premiumRequired=false é emergência/homologação e libera os módulos a todos.
- `MP_ENFORCE_PREMIUM` fica obsoleta, é ignorada após instalar o backend V3.10. Pode ser removida depois que a nova versão estiver homologada; não é necessário mexer em tokens.

## Ordem de deploy
1. Atualizar o backend no Heroku primeiro; confirmar que a compilação passou e a versão iniciou.
2. Atualizar o frontend na Vercel.
3. Entrar no painel `Administração > Configurações`, definir **0** dias e marcar **Exigir assinatura Premium**; clicar em **Salvar configurações**.
4. Testar com conta motoboy NOVA e sem Pix aprovado: tela de bloqueio e botão **Gerar Pix**. Testar também a tela de assinatura e a conta Admin.
5. Confirmar que o Pix aprovado libera todos os módulos por 7 dias e a renovação após expiração funciona.

**Atenção:** o backend V3.10 exige Premium como padrão quando não há configuração explícita. Antes de publicar, assegure que os métodos de pagamento estão funcionais e que você tem acesso ao admin. A proteção é auditada, reversível pelo painel e não deleta dados.
