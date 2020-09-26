import { Double } from 'mongodb';
import * as mongoose from 'mongoose';

interface IExpense {
	_id: string;
	userId: string;
	where: string;
	amount: number;
	date: string;
}

const ExpenseSchema = new mongoose.Schema({
	userId: String,
	where: String,
	amount: Number,
	date: Date
});

const ExpenseModel = mongoose.model('Expense', ExpenseSchema);

export { ExpenseModel, IExpense }