const express = require('express')
const cors = require('cors')
const porta = 3000
const app = express()
app.use(cors())


const conexao = require("./db.js")

//consegue acessar ps dados do body
app.use(express.json())

//módulo crypto
const crypto = require('crypto')


app.listen(porta, () => {
    console.log(`servidor rodando em : http://localhost:${porta}`)
})


// Fale Conosco
app.post("/FaleConosco", async (req, res) => {
    try {
        const { Nome, Email, Telefone, Assunto, Mensagem } = req.body

        if (!Nome || Nome.length < 6) {
            return res.status(400).json({ "resposta": "Insira um nome válido (mínimo 6 caracteres)" })
        }
        if (!Email || Email.length < 6) {
            return res.status(400).json({ "resposta": "Insira um email válido (mínimo 6 caracteres)" })
        }
        if (!Assunto || Assunto.length < 6) {
            return res.status(400).json({ "resposta": "Insira um assunto (mínimo 6 caracteres)" })
        }
        if (!Mensagem || Mensagem.length < 6) {
            return res.status(400).json({ "resposta": "Insira uma mensagem (mínimo 6 caracteres)" })
        }

        // Verificar se o e-mail está cadastrado na tabela 'usuarios' 
        
        const emailToSearch = Email.trim();

        let sqlCheckUser = 'SELECT email_cadastro FROM usuarios WHERE email_cadastro = ?';
        let [userResult] = await conexao.query(sqlCheckUser, [emailToSearch]);

        if (userResult.length === 0) {
            // Se o e-mail não foi encontrado na tabela de usuários
            return res.status(400).json({ "resposta": "Esse email não está cadastrado, faça o cadastro" });
        }

        // Preparar e Salvar a Mensagem de Contato na tabela 'Contato'

        const Data_envio = new Date() // Grava data/hora no servidor
        const Status = "Aguardando Leitura"

        const sqlInsert = `INSERT INTO Contato (Nome, Email, Telefone, Assunto, Mensagem, Data_envio, Status) VALUES (?, ?, ?, ?, ?, ?, ?)`

        const [resultado2] = await conexao.query(sqlInsert, [
            Nome.trim(),
            emailToSearch, // Usando o email já trimado
            Telefone ? Telefone.trim() : null,
            Assunto.trim(),
            Mensagem.trim(),
            Data_envio,
            Status
        ])

        if (resultado2.affectedRows === 1) {
            return res.status(201).json({ resposta: "Sucesso!" })
        } else {
            return res.status(500).json({ resposta: "Erro ao salvar a mensagem" })
        }

    } catch (error) {
        console.error("Erro na rota /FaleConosco:", error)
        return res.status(500).json({ resposta: "Erro inesperado no servidor ao processar a mensagem" })
    }
})

app.post("/Cadastrar", async (req, res) => {
    try {
        const { nome_completo_cadastro, cpf_cadastro, email_cadastro, data_nascimento_cadastro, endereco_cadastro, telefone_cadastro } = req.body;

        let { senha_cadastro } = req.body;


        senha_cadastro = senha_cadastro.trim();

        if (senha_cadastro === "") {
            return res.json({ resposta: "Preencha sua senha" });
        }

        if (senha_cadastro.length < 6) {
            return res.json({ resposta: "A senha tem que conter no mínimo 6 caracteres" });
        }


        if (!nome_completo_cadastro || nome_completo_cadastro.length < 6) {
            return res.json({ resposta: "Insira um nome válido" });
        }


        if (!cpf_cadastro || cpf_cadastro.length !== 11) {
            return res.json({ resposta: "CPF inválido" });
        }


        if (!email_cadastro || email_cadastro.length < 6) {
            return res.json({ resposta: "Insira um email válido" });
        }

        // CHECAR SE EMAIL já existe 
        let sql = 'SELECT * FROM usuarios WHERE email_cadastro = ?';
        let [resultado] = await conexao.query(sql, [email_cadastro]);

        if (resultado.length > 0) {
            return res.json({ resposta: "E-mail já cadastrado" });
        }

        // senha de dificil acesso
        const hash = crypto.createHash("sha256").update(senha_cadastro).digest("base64");


        sql = `INSERT INTO usuarios (nome_completo_cadastro, cpf_cadastro, email_cadastro, data_nascimento_cadastro, endereco_cadastro, telefone_cadastro, senha_cadastro) VALUES (?, ?, ?, ?, ?, ?, ?)`;

        let [resultado2] = await conexao.query(sql, [
            nome_completo_cadastro, cpf_cadastro, email_cadastro, data_nascimento_cadastro, endereco_cadastro, telefone_cadastro, hash]);

        if (resultado2.affectedRows === 1) {
            return res.json({ resposta: "Cadastro efetuado com sucesso!" });
        } else {
            return res.json({ resposta: "Erro ao fazer cadastro!" });
        }

    } catch (error) {
        console.log(error);
        return res.json({ resposta: "Erro no servidor" });
    }
});



app.post("/login", async (req, res) => {
    try {
        const { email_cadastro } = req.body;
        let { senha_cadastro } = req.body;

        if (!senha_cadastro || senha_cadastro.trim() === "") {
            return res.json({ resposta: "Preencha sua senha" });
        }

        senha_cadastro = senha_cadastro.trim();

        if (senha_cadastro.length < 6) {
            return res.json({ resposta: "A senha deve conter no mínimo 6 caracteres" });
        }

        const hash = crypto.createHash("sha256").update(senha_cadastro).digest("base64");

        const sql = `SELECT * FROM usuarios WHERE email_cadastro = ? AND senha_cadastro = ?`;

        const [resultado] = await conexao.query(sql, [email_cadastro, hash]);

        if (resultado.length > 0) {
            return res.json({ resposta: "valido", usuario: resultado[0] });
        } else {
            return res.json({ resposta: "invalido" });
        }

    } catch (error) {
        console.log(error);
        return res.json({ resposta: "Erro no servidor" });
    }
});


