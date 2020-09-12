
exports.addReg = (req, res) => {
    const mysql = require('mysql')
    const dbSocketAddr = process.env.DB_HOST.split(":")
    let name = req.query.name || req.body.name || '';
    let sql = `INSERT INTO worker_arrival(date, name)
               VALUES(now(),'${name}')`;
    const connection = mysql.createConnection({
    host     : dbSocketAddr[0],
    port     : dbSocketAddr[1],
    user     : process.env.DB_USER,
    password : process.env.DB_PASS,
    database : process.env.DB_NAME
  });
    
    var out = null
    try{
      connection.query(sql);
      out = true
    } catch (err){
      out = err
    }
    res.status(200).send({
      DB_HOST:process.env.DB_HOST,
      DB_USER:process.env.DB_USER,
      DB_PASS:process.env.DB_PASS,
      DB_NAME:process.env.DB_NAME,
      name:name,
      out:out
    });  
    };  