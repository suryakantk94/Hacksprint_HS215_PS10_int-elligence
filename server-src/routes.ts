/* tslint:disable */
import { Controller, ValidationService, FieldErrors, ValidateError, TsoaRoute } from 'tsoa';
import { UserController } from './controllers/user.controller';
import { ExpenseController } from './controllers/expense.controller';
import * as express from 'express';

const models: TsoaRoute.Models = {

    "IUser": {
        "properties": {
            "_id": { "dataType": "string", "required": true },
            "username": { "dataType": "string", "required": true },
            "password": { "dataType": "string", "required": true },
            "phoneNumber": { "dataType": "string", "required": false },
            "monthlyIncome": { "dataType": "double", "required": false },
            "saving": { "dataType": "double", "required": false },
            "dailyLimit": { "dataType": "double", "required": false },
        },
    },
    "IExpense": {
        "properties": {
            "_id": { "dataType": "string", "required": true },
            "where": { "dataType": "string", "required": false },
            "amount": { "dataType": "double", "required": true },
            "date": { "dataType": "string", "required": true }
        },
    }
};
const validationService = new ValidationService(models);

export function RegisterRoutes(app: express.Express) {
    app.get('/users',
        function (request: any, response: any, next: any) {
            const args = {
            };

            let validatedArgs: any[] = [];
            try {
                validatedArgs = getValidatedArgs(args, request);
            } catch (err) {
                return next(err);
            }

            const controller = new UserController();


            const promise = controller.getAll.apply(controller, validatedArgs as any);
            promiseHandler(controller, promise, response, next);
        });
    app.post('/users',
        function (request: any, response: any, next: any) {
            const args = {
                username: { "in": "body-prop", "name": "username", "required": true, "dataType": "string" },
                password: { "in": "body-prop", "name": "password", "required": true, "dataType": "string" },
                phoneNumber: { "in": "body-prop", "name": "phoneNumber", "required": false, "dataType": "string" },
            };

            let validatedArgs: any[] = [];
            try {
                validatedArgs = getValidatedArgs(args, request);
            } catch (err) {
                return next(err);
            }

            const controller = new UserController();


            const promise = controller.create.apply(controller, validatedArgs as any);
            promiseHandler(controller, promise, response, next);
        });

    app.post('/login',
        function (request: any, response: any, next: any) {
            const args = {
                username: { "in": "body-prop", "name": "username", "required": true, "dataType": "string" },
                password: { "in": "body-prop", "name": "password", "required": true, "dataType": "string" },
            };

            let validatedArgs: any[] = [];
            try {
                validatedArgs = getValidatedArgs(args, request);
            } catch (err) {
                return next(err);
            }

            const controller = new UserController();


            const promise = controller.authenticate.apply(controller, validatedArgs as any);
            promiseHandler(controller, promise, response, next);
        });
    app.put('/users/:id',
        function (request: any, response: any, next: any) {
         
            const args = {
                id: { "in": "path", "name": "id", "required": true, "dataType": "string" },
                monthlyIncome: { "in": "body-prop", "name": "monthlyIncome", "required": false, "dataType": "number" },
                dailyLimit: { "in": "body-prop", "name": "dailyLimit", "required": false, "dataType": "number" },
                saving: { "in": "body-prop", "name": "saving", "required": false, "dataType": "number" },
            };
            let validatedArgs: any[] = [];
            try {
                validatedArgs = getValidatedArgs(args, request);
            } catch (err) {
                return next(err);
            }

            const controller = new UserController();
            const promise = controller.update.apply(controller, validatedArgs as any);
            promiseHandler(controller, promise, response, next);
        });
    app.get('/users/:id',
        function (request: any, response: any, next: any) {
            const args = {
                id: { "in": "path", "name": "id", "required": true, "dataType": "string" }

            };
            console.log(request);
            let validatedArgs: any[] = [];
            try {
                validatedArgs = getValidatedArgs(args, request);
            } catch (err) {
                return next(err);
            }

            const controller = new UserController();
            const promise = controller.getOne.apply(controller, validatedArgs as any);
            promiseHandler(controller, promise, response, next);
        });
    app.post('/expenses',
        function (request: any, response: any, next: any) {
            const args = {
                userId: { "in": "body-prop", "name": "userId", "required": true, "dataType": "string" },
                where: { "in": "body-prop", "name": "where", "required": true, "dataType": "string" },
                amount: { "in": "body-prop", "name": "amount", "required": true, "dataType": "double" },
                date: { "in": "body-prop", "name": "date", "required": false, "dataType": "string" },
            };

            let validatedArgs: any[] = [];
            try {
                validatedArgs = getValidatedArgs(args, request);
            } catch (err) {
                return next(err);
            }

            const controller = new ExpenseController();


            const promise = controller.create.apply(controller, validatedArgs as any);
            promiseHandler(controller, promise, response, next);
        });
    app.get('/expenses/:userid',
        function (request: any, response: any, next: any) {
            const args = {
                id: { "in": "path", "name": "userid", "required": true, "dataType": "string" }
            };

            let validatedArgs: any[] = [];
            try {
                validatedArgs = getValidatedArgs(args, request);
            } catch (err) {
                return next(err);
            }

            const controller = new ExpenseController();


            const promise = controller.get.apply(controller, validatedArgs as any);
            promiseHandler(controller, promise, response, next);
        });

    function isController(object: any): object is Controller {
        return 'getHeaders' in object && 'getStatus' in object && 'setStatus' in object;
    }

    function promiseHandler(controllerObj: any, promise: any, response: any, next: any) {
        return Promise.resolve(promise)
            .then((data: any) => {
                let statusCode;
                if (isController(controllerObj)) {
                    const headers = controllerObj.getHeaders();
                    Object.keys(headers).forEach((name: string) => {
                        response.set(name, headers[name]);
                    });

                    statusCode = controllerObj.getStatus();
                }

                if (data || data === false) { // === false allows boolean result
                    response.status(statusCode || 200).json(data);
                } else {
                    response.status(statusCode || 204).end();
                }
            })
            .catch((error: any) => next(error));
    }

    function getValidatedArgs(args: any, request: any): any[] {
        const fieldErrors: FieldErrors = {};
        const values = Object.keys(args).map((key) => {
            const name = args[key].name;
            switch (args[key].in) {
                case 'request':
                    return request;
                case 'query':
                    return validationService.ValidateParam(args[key], request.query[name], name, fieldErrors);
                case 'path':
                    return validationService.ValidateParam(args[key], request.params[name], name, fieldErrors);
                case 'header':
                    return validationService.ValidateParam(args[key], request.header(name), name, fieldErrors);
                case 'body':
                    return validationService.ValidateParam(args[key], request.body, name, fieldErrors, name + '.');
                case 'body-prop':
                    return validationService.ValidateParam(args[key], request.body[name], name, fieldErrors, 'body.');
            }
        });
        if (Object.keys(fieldErrors).length > 0) {
            throw new ValidateError(fieldErrors, '');
        }
        return values;
    }
}
