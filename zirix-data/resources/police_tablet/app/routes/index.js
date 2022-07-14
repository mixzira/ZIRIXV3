const express = require('express');
const arrest = require('./arrestRoutes');

const routes = (app) => {
    app.route('/').get((req, res) => {
        res.status(200).send('Sistema de Policia')
    })

    app.use(
        express.json(),
        arrest,
    )
}

module.exports = routes