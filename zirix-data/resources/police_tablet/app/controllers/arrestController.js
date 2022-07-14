class arrestController {
    static arrestPlayer = async (req, res) => {
        console.log(req.body);
        res.status(200);
    }
}

module.exports = arrestController