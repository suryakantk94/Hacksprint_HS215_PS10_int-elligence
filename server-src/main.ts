import { app } from './app';
import * as http from 'http';

import * as mongoose from 'mongoose';

const PORT = process.env.PORT || 8080;
const MONGO_URI = "mongodb+srv://intelligence:Intelligence123@cluster0.aej8r.mongodb.net/pockett?retryWrites=true&w=majority";

const server = http.createServer(app);
server.listen(PORT);
server.on('listening', async () => {
	console.info(`Listening on port ${PORT}`);
	mongoose.connect(MONGO_URI, { useNewUrlParser: true, useFindAndModify: false });
	mongoose.connection.on('open', () => {
		console.info('Connected to Mongo.');
	});
	mongoose.connection.on('error', (err: any) => {
		console.error(err);
	});
});