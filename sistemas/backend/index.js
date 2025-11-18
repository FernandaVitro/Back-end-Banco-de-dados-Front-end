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

// Rota 
app.post("/FaleConosco", async (req, res) => {
    try {
        const { Nome,Email,Telefone,Assunto,Mensagem } = req.body

        
        if (Nome.length < 6) {
            return res.status(400).json({"resposta":"Insira um nome"})
        }
        else if (Email.length < 6) {
            return res.status(400).json({"resposta":"Insira um email"})
        }
        else if (Assunto.length < 6) {
            return res.status(400).json({"resposta":"Insira um assunto"})
        }
        else if (Mensagem.length < 6) {
            return res.status(400).json({"resposta":"Insira uma mensagem"})
        }
        
     
        // Verificar se o e-mail já está cadastrado

        let sql = 'Select * from FaleConosco where email = ?'
        let [resultado] = await conexao.query(sql,[Email])
        
        if (resultado.length != 0){
            return res.status(409).json({"resposta":"E-mail já cadastrado"})
        }

        // Preparar dados a salvar (RF-004 e RF-005) 
        const Data_envio = new Date() // grava data/hora no servidor
        const Status = "Aguardando Leitura"

        const sqlInsert = `INSERT INTO FaleConosco (Nome, Email, Telefone, Assunto, Mensagem, Data_envio, Status) VALUES (?, ?, ?, ?, ?, ?, ?)`

        const [resultado2] = await conexao.query(sqlInsert, [
            Nome.trim(),
            Email.trim(),
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
        console.error(error)
        return res.status(500).json({ resposta: "Erro inesperado" })
    }
})