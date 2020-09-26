import * as mongoose from 'mongoose';

interface IUser {
	_id: string;
	username: string;
	password: string;
	phoneNumber: string;
	monthlyIncome: number;
	dailyLimit: number;
	saving: number;
}

const UserSchema = new mongoose.Schema({
	username: String,
	password: String,
	phoneNumber: String,
	monthlyIncome: Number,
	dailyLimit: Number,
	saving: Number
});

const UserModel = mongoose.model('User', UserSchema);

export { UserModel, IUser }