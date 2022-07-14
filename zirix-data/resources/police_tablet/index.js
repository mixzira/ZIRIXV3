const app = require('./app/app');

const port = 3558

app.listen(port, () => {
    console.log(`Servidor escutando em http://localhost:${port}`)
})