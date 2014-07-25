//
//  SecretViewModel.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/24/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

class SecretViewModel: NSObject {
    
    var secret: Secret
    var commentText = ""
    
    lazy var postingEnabled: RACSignal = (self ~~ "commentText")
        .map { ($0 as NSString).length > 3 }
    
    init(secret: Secret) {
        self.secret = secret
    }
    
    func postComment() -> RACSignal {
        return RACSignal.createSignal { subscriber in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
                let secret = self.secret
                let text = self.commentText
                let avatar = Avatar.Regular(.Owl, .Violet)
                let comment = Comment(avatar: avatar, text: text)
                secret.commentCount += 1
                secret.comments.append(comment)
                subscriber.sendNext(comment)
                subscriber.sendCompleted()
            }
            
            return nil
        }
    }
    
    lazy var postCommand: RACCommand = RACCommand(enabled: self.postingEnabled) { _ in
        return self.postComment()
    }
    
}