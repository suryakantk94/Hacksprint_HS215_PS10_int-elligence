import { UserModel, IUser } from '../models/user';
import { Controller, Route, Get, Post, BodyProp, Put, Delete } from 'tsoa';

@Route('/user')
export class UserController extends Controller {
	@Get()
	public async getAll(): Promise<IUser[]> {
		try {
			let items: any = await UserModel.find({});
			items = items.map((item) => { return {id: item._id, username: item.username, password: item.password, phoneNumber: item.phoneNumber}});
			return items;
		} catch (err) {
			this.setStatus(500);
			console.error('Caught error', err);
		}
	}

	@Post()
	public async authenticate(@BodyProp() username: string, @BodyProp() password: string) : Promise<IUser> {
		try {
			let item: any = await UserModel.findOne({username: username, password: password});
			// items = items.map((item) => { return {id: item._id, username: item.username, password: item.password, phoneNumber: item.phoneNumber}});
			console.log(item)
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
	public async create(@BodyProp() username: string, @BodyProp() password: string, @BodyProp() phoneNumber: string) : Promise<void> {
		const item = new UserModel({username: username, password: password, phoneNumber: phoneNumber});
		await item.save();
	}

	@Put('/{id}')
	public async update(id: string, @BodyProp() username: string, @BodyProp() password: string, @BodyProp() phoneNumber: string) : Promise<void> {
		await UserModel.findOneAndUpdate({_id: id}, {username: username, password: password, phoneNumber: phoneNumber});
	}

	@Delete('/{id}')
	public async remove(id: string) : Promise<void> {
		await UserModel.findByIdAndRemove(id);
	}
}
