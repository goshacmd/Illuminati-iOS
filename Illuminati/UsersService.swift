//
//  UsersService.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import Foundation

let kUserErrorDomain = "name.goshakkk.user-service"

enum UserError: Int {
    case InvalidCredentials
}

let invalidCredentialsError = NSError(domain: kUserErrorDomain, code: UserError.InvalidCredentials.toRaw(), userInfo: ["title": "Invalid credentails", "message": "The credentials you enetred didn't match. Try again"])

class UsersService {
    
    var currentUser: User?
    
    class var sharedService: UsersService {
        struct Singleton {
            static let instance = UsersService()
        }

        return Singleton.instance
    }
    
    func signIn(email: String, password: String) -> RACSignal {
        return RACSignal.createSignal { subscriber in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
                if email == "a@b.c" && password == "mmmm" {
                    let user = User(email: email)
                    self.currentUser = user
                    subscriber.sendNext(user)
                    subscriber.sendCompleted()
                } else {
                    subscriber.sendError(invalidCredentialsError)
                }
            }
            
            return nil
        }
    }
    
    func signUp(email: String, phone: String, password: String) -> RACSignal {
        return RACSignal.createSignal { subscriber in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
                let user = User(email: email)
                self.currentUser = user
                subscriber.sendNext(user)
                subscriber.sendCompleted()
            }
            
            return nil
        }
    }
}
