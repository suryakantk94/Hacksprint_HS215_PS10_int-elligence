import {getRepository} from "typeorm";
import {NextFunction, Request, Response} from "express";
import {User} from "../entity/User";

export class UserController {

    private userTable = getRepository(User);

    async all(request: Request, response: Response, next: NextFunction) {
        return this.userTable.find();
    }

    async one(request: Request, response: Response, next: NextFunction) {
        return this.userTable.findOne(request.params.username);
    }

    async register(request: Request, response: Response, next: NextFunction) {
        return this.userTable.save(request.body);
    }
    
    async login(request: Request, response: Response, next: NextFunction) {
        //Check if username and password are set
    let { username, password } = request.body;
    if (!(username && password)) {
      response.status(400).send();
    }

    //Get user from database
    // const userRepository = getRepository(User);
    // let user: User;
    // try {
    //   user = await userRepository.findOneOrFail({ where: { username } });
    // } catch (error) {
    //   res.status(401).send();
    // }

    // //Check if encrypted password match
    // if (!user.checkIfUnencryptedPasswordIsValid(password)) {
    //   res.status(401).send();
    //   return;
    // }

    // //Sing JWT, valid for 1 hour
    // const token = jwt.sign(
    //   { userId: user.id, username: user.username },
    //   config.jwtSecret,
    //   { expiresIn: "1h" }
    // );

    // //Send the jwt in the response
    // res.send(token);
        // return this.userTable.findOne("Areeba");
    }
    async remove(request: Request, response: Response, next: NextFunction) {
        let userToRemove = await this.userTable.findOne(request.params.username);
        await this.userTable.remove(userToRemove);
    }

}