import { UserModel, IUser } from '../models/user';
import { Controller, Route, Get, Post, BodyProp, Put, Delete } from 'tsoa';

@Route('/user')
export class UserController extends Controller {
	@Get()
	public async getAll(): Promise<IUser[]> {
		try {
			let items: any = await UserModel.find({});
			items = items.map((item) => { return { id: item._id, username: item.username, password: item.password, phoneNumber: item.phoneNumber, monthlyIncome: item.monthlyIncome, dailyLimit: item.dailyLimit, saving: item.saving } });
			return items;
		} catch (err) {
			this.setStatus(500);
			console.error('Caught error', err);
		}
	}

	@Post()
	public async authenticate(@BodyProp() username: string, @BodyProp() password: string): Promise<IUser> {
		try {
			let item: any = await UserModel.findOne({ username: username, password: password });
			// items = items.map((item) => { return {id: item._id, username: item.username, password: item.password, phoneNumber: item.phoneNumber}});

			if (item == null) {
				this.setStatus(401);
				console.error('Incorrect username or password');
			} else {
				return item;
			}
		} catch (err) {
			this.setStatus(500);
			console.error('Caught error', err);
		}
	}

	@Post()
	public async create(@BodyProp() username: string, @BodyProp() password: string, @BodyProp() phoneNumber: string): Promise<void> {
		const item = new UserModel({ username: username, password: password, phoneNumber: phoneNumber, monthlyIncome: 0, dailyLimit: 0, saving: 0 });
		await item.save();
	}

	@Put('/{id}')
	public async update(id: string, @BodyProp() monthlyIncome: number, @BodyProp() dailyLimit: number, @BodyProp() saving: number): Promise<void> {

		if (monthlyIncome != undefined) {
			await UserModel.findOneAndUpdate({ _id: id }, { monthlyIncome: monthlyIncome });
		} else if (dailyLimit != undefined) {
			await UserModel.findOneAndUpdate({ _id: id }, { dailyLimit: dailyLimit });
		} else if (saving != undefined) {
			let existing = await this.getOne(id);
			await UserModel.findOneAndUpdate({ _id: id }, { saving: existing["saving"] + saving });
		}
	}
	@Get('/{id}')
	public async getOne(id: string): Promise<void> {
		try {
			console.log(id);
			let items: any = await UserModel.find({ _id: id });
			items = items.map((item) => { return { id: item._id, username: item.username, password: item.password, phoneNumber: item.phoneNumber, monthlyIncome: item.monthlyIncome, dailyLimit: item.dailyLimit, saving: item.saving } });
			return items[0];
		} catch (err) {
			this.setStatus(500);
			console.error('Caught error', err);
		}

	}

	@Delete('/{id}')
	public async remove(id: string): Promise<void> {
		await UserModel.findByIdAndRemove(id);
	}
}
