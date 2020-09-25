import * as mongoose from 'mongoose';

interface IUser {
	_id: string;
	username: string;
	password: string;
	phoneNumber: string;
}

const UserSchema = new mongoose.Schema({
	username: String,
	password: String,
	phoneNumber: String
});

const UserModel = mongoose.model('User', UserSchema);

export { UserModel, IUser }