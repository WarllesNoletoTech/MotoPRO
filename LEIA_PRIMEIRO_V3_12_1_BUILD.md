# MotoPRO V3.12.1 - Correção de build Heroku

O deploy da V3.12 falhava em `src/routes/account.ts` com **TS2339** na propriedade `createdAt`.

**Corrigido:** tipagem explícita para o documento retornado por `User.findById().lean()`;
a exportação continua calculando o teste pelo valor atual `settings.trialDays` do administrador.

**Publicação:** copie a pasta `backend-MotoPRO` atualizada para o repositório do backend e
realize o deploy no Heroku. Mantenha o frontend V3.12 já implantado. Não altere Pix,
credenciais ou MongoDB.

**Verificação:** este pacote passou na análise sintática de TypeScript e teste de integridade ZIP.
O build completo com bibliotecas ainda precisa ser confirmado no Heroku.
