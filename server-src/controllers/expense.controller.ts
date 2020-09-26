import { ExpenseModel, IExpense } from '../models/expense';
import { Controller, Route, Get, Post, BodyProp } from 'tsoa';
import { IUser, UserModel } from '../models/user';

@Route('/expense')
export class ExpenseController extends Controller {
	@Get('/{userid}')
	public async get(userid: string): Promise<IExpense[]> {
		try {
			// let items: any = await ExpenseModel.find({});
			// items = items.map((item) => { return {id: item._id, where: item.where, amount: item.amount, date: item.date}});

			let items: any = await ExpenseModel.aggregate([
				{ $match: { userId: userid } },
				{ $group: { _id: "$date", Amount: { $sum: "$amount" } } }]);
			console.log(userid);
			items = items.map((item) => { return { total: item.Amount, date: item._id } });

			return items;
		} catch (err) {
			this.setStatus(500);
			console.error('Caught error', err);
		}
	}




	@Post()
	public async create(@BodyProp() userId, @BodyProp() where: string, @BodyProp() amount: number, @BodyProp() date: string): Promise<any> {

		// Create date from input value
		var inputDate = new Date(date);
		console.log("inputDate: " + inputDate)
		// Get today's date
		let dateUTC = new Date();
		let dateUTCMilli = dateUTC.getTime();
		var todaysDate = new Date(dateUTCMilli);
		console.log("todaysDate: " + todaysDate)

		//date shifting for IST timezone (+5 hours and 30 minutes)
		todaysDate.setHours(todaysDate.getHours() + 5);
		todaysDate.setMinutes(todaysDate.getMinutes() + 30);

		let newDailyLimit = 0;
		let toReturn = null;
		// call setHours to take the time out of the comparison
		if (inputDate.setHours(0, 0, 0, 0) == todaysDate.setHours(0, 0, 0, 0)) {
			// Date equals today's date
			console.log("Date is equal to today's date. Checking if user exceeded daily limit");

			// Get today's expenses
			let items: any = await ExpenseModel.aggregate([
				{ $match: { userId: userId } }, // Get only those records with userID and given date
				{ $group: { _id: "$date", Amount: { $sum: "$amount" } } }]); // Sum all the expenses for given date
			items = items.filter(function (item) {
				return inputDate.setHours(0, 0, 0, 0) == new Date(item._id).setHours(0, 0, 0, 0);
			});
			let existingTodaysExpenses = 0;
			if (items.length != 0) {
				existingTodaysExpenses = items[0]["Amount"];
			}
			console.log("existingTodaysExpenses " + existingTodaysExpenses)

			// Get current dailylimit
			items = await UserModel.find({ _id: userId });
			items = items.map((item) => { return { id: item._id, username: item.username, password: item.password, phoneNumber: item.phoneNumber, monthlyIncome: item.monthlyIncome, dailyLimit: item.dailyLimit, saving: item.saving } });
			let currDailyLimit = items[0];
			currDailyLimit = currDailyLimit["dailyLimit"];
			console.log("currDailyLimit: " + currDailyLimit)

			// Check if dailyLimit exceeded
			if (existingTodaysExpenses + amount > currDailyLimit) {
				let noDaysInCurrMonth = new Date(todaysDate.getFullYear(), todaysDate.getMonth() + 1, 0).getDate();
				let remDaysInCurrMonth = noDaysInCurrMonth - todaysDate.getDate();

				// Calculate allowed expenses for current month with current daily limit
				let allowedExpensesForCurrMonth = currDailyLimit * noDaysInCurrMonth;
				console.log("noDaysInCurrMonth: " + noDaysInCurrMonth);
				console.log("remDaysInCurrMonth: " + remDaysInCurrMonth);
				console.log("allowedExpensesForCurrMonth: " + allowedExpensesForCurrMonth);

				// Get total expenditure already incurred this month
				let currTotalExpensesForCurrMonth = amount;
				let items: any = await ExpenseModel.aggregate([
					{ $match: { userId: userId } }, // Get expenses for userid
					{ $group: { _id: { $month: "$date" }, Amount: { $sum: "$amount" } } }]); // Group by month
				items = items.map((item) => { return { total: item.Amount, month: item._id } });
				items = items.filter(function (item) {
					return item.month == todaysDate.getMonth() + 1;
				});
				if (items.length != 0) {
					currTotalExpensesForCurrMonth = items[0]["total"] + amount
				}
				console.log("currTotalExpensesForCurrMonth: " + currTotalExpensesForCurrMonth)

				// Adjust daily limit
				newDailyLimit = (allowedExpensesForCurrMonth - currTotalExpensesForCurrMonth) / remDaysInCurrMonth;
				if (newDailyLimit < 0) {
					newDailyLimit = 0;
				}
				newDailyLimit = Math.round((newDailyLimit + Number.EPSILON) * 100) / 100;
				toReturn = await UserModel.findOneAndUpdate({ _id: userId }, { dailyLimit: newDailyLimit }, { new: true });
			} else {
				newDailyLimit = currDailyLimit;
				toReturn = await UserModel.findOne({ _id: userId });
			}

		}
		let item = new ExpenseModel({ userId: userId, where: where, amount: amount, date: date });
		await item.save();
		toReturn = await UserModel.findOne({ _id: userId });

		return toReturn;
	}



}
