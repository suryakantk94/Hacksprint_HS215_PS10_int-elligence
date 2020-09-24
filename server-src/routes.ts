import {UserController} from "./controller/UserController";

export const Routes = [{
    method: "get",
    route: "/users",
    controller: UserController,
    action: "all"
}, {
    method: "get",
    route: "/users/:username",
    controller: UserController,
    action: "one"
}, {
    method: "post",
    route: "/users",
    controller: UserController,
    action: "register"
}, {
    method: "delete",
    route: "/users/:username",
    controller: UserController,
    action: "remove"
},{
    method: "post",
    route: "/login",
    controller: UserController,
    action: "login"
}];