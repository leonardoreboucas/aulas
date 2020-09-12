
exports.addReg = (req, res) => {
    let name = req.query.name || req.body.name || '';
  
    const createTcpPool = async (config) => {
    // Extract host and port from socket address
    const dbSocketAddr = process.env.DB_HOST.split(":")
  
    // Establish a connection to the database
    let connection = await mysql.createPool({
      user: process.env.DB_USER, // e.g. 'my-db-user'
      password: process.env.DB_PASS, // e.g. 'my-db-password'
      database: process.env.DB_NAME, // e.g. 'my-database'
      host: dbSocketAddr[0], // e.g. '127.0.0.1'
      port: dbSocketAddr[1], // e.g. '3306'
      // ... Specify additional properties here.
      ...config
    });
  }
  
  let sql = `INSERT INTO shifts(date, name)
             VALUES(now(),${name})`;
  
  connection.query(sql);
  connection.end();
    res.status(200).send({result:true});
  };
  