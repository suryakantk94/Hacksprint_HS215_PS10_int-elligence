import {Entity, PrimaryColumn, Column} from "typeorm";

@Entity({name: "users"})
export class User {

    @PrimaryColumn()
    username: string;

    @Column()
    password: string;

    @Column()
    phoneNumber: string;

}
