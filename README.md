# API REST — Conversão e Registro de Medições

API desenvolvida com Node.js, Express e MySQL (`mysql2/promise`) para cadastrar, consultar, atualizar e remover medições de temperatura.

## 1. Requisitos

- Node.js 18 ou superior
- MySQL 8 (ou compatível)
- npm

## 2. Configuração

1. Crie o banco e a tabela executando `database.sql` no MySQL Workbench ou no cliente MySQL.
2. Instale as dependências:

   ```bash
   npm install
   ```

3. Copie `.env.you` para `.env` e informe as credenciais do seu MySQL.
4. Inicie a API:

   ```bash
   npm start
   ```

A API ficará disponível em `http://localhost:3000`.

## 3. Rotas

| Método | Rota | Descrição |
|---|---|---|
| GET | `/` | Verifica se a API está operacional |
| GET | `/medicao` | Lista todas as medições |
| GET | `/medicao/temperatura_ideal` | Lista medições classificadas como ideais |
| GET | `/medicao/:id` | Busca uma medição pelo ID |
| POST | `/medicao` | Cadastra uma medição |
| PUT | `/medicao/:id` | Atualiza uma medição |
| DELETE | `/medicao/:id` | Exclui uma medição |

## 4. Exemplo de POST

URL: `http://localhost:3000/medicao`

Método: `POST`  
Cabeçalho: `Content-Type: application/json`

```json
{
  "descricao": "Teste de overclock de processador",
  "tipo": "temperatura",
  "valor": 100
}
```

Resposta esperada (201):

```json
{
  "id": 1,
  "descricao": "Teste de overclock de processador",
  "tipo": "temperatura",
  "valor_original": 100,
  "unidade_original": "celsius",
  "valor_convertido": 212,
  "unidade_convertida": "fahrenheit",
  "classificacao": "Acima da temperatura ideal"
}
```

## 5. Regra de conversão e classificação

A conversão é:

`F = (C * 9 / 5) + 32`

O resultado é arredondado para duas casas decimais.

- Abaixo de 80 °C: `Temperatura ideal`
- De 80 °C até abaixo de 95 °C: `Faixa não especificada`
- De 95 °C até 105 °C, inclusive: `Acima da temperatura ideal`
- Acima de 105 °C: `Limite crítico`

## 6. Validações e erros

- POST e PUT exigem `descricao`, `tipo` e `valor`.
- O único tipo aceito é `temperatura`.
- Valores não numéricos são rejeitados.
- IDs inexistentes retornam 404.
- Erros internos do banco retornam 500 com a propriedade `detalhes`.
- As consultas usam parâmetros (`?`) para evitar concatenar valores diretamente no SQL.

## 7. Testes da regra de conversão

Execute:

```bash
npm test
```

Os testes verificam a conversão, o arredondamento, as classificações e a rejeição de entradas inválidas.

## 8. Exemplos de PUT e DELETE

PUT `/medicao/1`:

```json
{
  "descricao": "Teste atualizado",
  "tipo": "temperatura",
  "valor": 110
}
```

DELETE `/medicao/1` não precisa de corpo JSON.

## 9. Estrutura do projeto

```text
api-medicoes/
├── database.sql
├── .env.example
├── .gitignore
├── package.json
├── README.md
├── src/
│   ├── config/
│   │   └── database.js
│   ├── routes/
│   │   └── medicoes.js
│   ├── utils/
│   │   └── medicao.js
│   └── server.js
└── test/
    └── medicao.test.js
```
