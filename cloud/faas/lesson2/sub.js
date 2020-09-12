//Node 12
exports.sub = (req, res) => {
    const x = req.query.x || req.body.x;
    const y = req.query.y || req.body.y;
    const result = parseFloat(x)-parseFloat(y); 
    res.status(200).send({result:result});
  };