//
//  SignInViewModel.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

class SignInViewModel: NSObject {
   
    var mode = "signIn"
    var email = ""
    var phone = ""
    var password = ""
    
    @lazy var validEmailSignal: RACSignal = (self ~~ "email")
        .map(^^self.isValidEmail)
    @lazy var validPasswordSignal: RACSignal = (self ~~ "password")
        .map(^^self.isValidPassword)
    @lazy var validPhoneSignal: RACSignal = (self ~~ "phone")
        .map(^^self.isValidPhone)
    @lazy var isSignInSignal: RACSignal = (self ~~ "mode").map { $0 as String == "signIn" }
    
    @lazy var validPhoneSignUpSignal: RACSignal = RACSignal
        .combineLatest([self.isSignInSignal, self.validPhoneSignal])
        .OR()
    
    @lazy var signInActiveSignal: RACSignal = RACSignal
        .combineLatest([self.validEmailSignal, self.validPhoneSignUpSignal, self.validPasswordSignal])
        .AND()
    
    var actionSignal: RACSignal {
        if self.mode == "signIn" {
            return UsersService.sharedService.signIn(self.email, password: self.password)
        } else {
            return UsersService.sharedService.signUp(self.email, phone: self.phone, password: self.password)
        }
    }
    
    @lazy var actionCommand: RACCommand = RACCommand(enabled: self.signInActiveSignal) { _ in
        return self.actionSignal
    }
    
    func toggleMode() {
        self.mode = self.mode == "signIn" ? "signUp" : "signIn"
    }
    
    func isValidEmail(email: NSString) -> Bool {
        return email.length > 3 && email.containsString("@")
    }
    
    func isValidPhone(phone: NSString) -> Bool {
        return phone.length > 5
    }
    
    func isValidPassword(password: NSString) -> Bool {
        return password.length > 3
    }
    
}
