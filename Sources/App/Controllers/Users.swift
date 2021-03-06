//
//  File.swift
//  
//
//  Created by Алексей Мальков on 05.01.2021.
//

import Foundation
import Vapor

class Users {
    let resulter = ShowResults()
    
    struct LoginGetParam: Content {
        var username: String?
        var password: String?
    }

    struct LogoutGetParam: Content {
        var userId: Int?
    }

    struct changeUserDataGetParam: Content {
        var username: String?
        var password: String?
        var first_name: String?
        var last_name: String?
        var email: String?
        var userId: Int?
    }
    
    func doAction(action: String, queryString: URLQueryContainer?) -> String {
        switch action {
        case "login":
            return login(queryString)
        case "logout":
            return logout(queryString)
        case "change":
            return changeUserData(queryString)
        case "register":
            return register(queryString)
        default:
            return resulter.returnError(message: "Unknown method")
        }
    }
    
    func login(_ queryString: URLQueryContainer?) -> String {
        guard let query = try? queryString?.get(LoginGetParam.self),
            let userName = query.username,
            userName == "Somebody",
            let userPassword = query.password,
            userPassword == "Password" else {
                return resulter.returnError(message: "User not found")
        }
        
        let user: Dictionary<String,Any> = ["id_user": 12,
                                               "user_login": userName,
                                               "user_name": "John",
                                               "user_lastname": "Doe"
        ]
        
        let result: Dictionary<String,Any> = ["authToken": "some_authorizaion_token", "user": user]
        
        
        return resulter.returnResult(result)
    }
    
    func logout(_ queryString: URLQueryContainer?) -> String {
        guard let query = try? queryString?.get(LogoutGetParam.self),
            let _ = query.userId else {
                return resulter.returnError(message: "User not found")
        }
        
        return resulter.returnResult()
    }
    
    func changeUserData(_ queryString: URLQueryContainer?) -> String {
        guard let query = try? queryString?.get(changeUserDataGetParam.self),
            let _ = query.username,
            let _ = query.password,
            let _ = query.first_name,
            let _ = query.last_name,
            let _ = query.email,
            let _ = query.userId else {
                return resulter.returnError(message: "You must spercify all parameter")
        }
        
        return resulter.returnResult()
    }
    
    func register(_ queryString: URLQueryContainer?) -> String {
        guard let query = try? queryString?.get(changeUserDataGetParam.self),
            let _ = query.username,
            let _ = query.password,
            let _ = query.first_name,
            let _ = query.last_name,
            let _ = query.email else {
                return resulter.returnError(message: "You must spercify all parameter")
        }
        
        let answer: Dictionary<String,String> = ["userMessage": "Регистрация прошла успешно!"]
        
        return resulter.returnResult(answer)
    }
}
