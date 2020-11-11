const express = require("express")
const debug = require("debug")("index")
const db = require("./db/mongoose")

const app = express()

const port = process.env.API_PORT

app.get("/", (req, res) => {
    res.send("OK")
})

app.listen(port, () =>
debug(`MERN app listening on port ${port}!`)
)