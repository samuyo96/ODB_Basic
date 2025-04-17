const oracledb = require('oracledb');

const dbConfig = {
	user: "USER",
	password: "1234Prueba56",
	connectString: "localhost:1521/FREE"
}

async function connectTest() {
	let connection;

	try {
		connection = await oracledb.getConnection(dbConfig);
		console.log("Conectado");
	} catch (err) {
		console.log("error en conexión", err);
	} finally {
		if (connection){
			try {
				await connection.close();
			}catch (err){
				console.log(err);
			}
		}
	}
};

async function connectToSamurai () {
	try {
		const connection = await oracledb.getConnection(dbConfig);
		console.log("Conectado");
		return connection;
	} catch (err) {
		console.error ("error en conexión", err);
		throw err;
	}
}

async function disconnectToSamurai(connection) {
	try{
		if (connection) {
			await connection.close();
			console.log("Desconexión")
		
		}
	} catch (err) {
		console.error ("error en desconexión", err);
		throw err;
	}
}

async function executeProcedure (connection, procedureName, params[]){
	try {
		const result = await connection.execute(
			`BEGIN ${procedureName}(:params); END;`, 
			{params}
		);
		console.log ("Resultado:", result);
	} catch (err) {
		console.error ("error al usar el procedimiento " + procedureName, err);
		throw err;
	}
}
