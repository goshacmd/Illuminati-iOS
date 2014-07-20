//
//  Secret.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class Secret: NSObject {
    
    var caption: String
    var background: UIColor
    var likeCount: Int
    var commentCount: Int
    var comments: [Comment]
    
    init(caption: String, background: UIColor, likeCount: Int, commentCount: Int, comments: [Comment] = []) {
        self.caption = caption
        self.background = background
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.comments = comments
    }
    
    class func all() -> [Secret] {
        let yellow = UIColor.yellowColor(),
            red = UIColor.redColor(),
            orange = UIColor.orangeColor(),
            green = UIColor.greenColor()
        
        return [
            Secret(caption: "My first secret...", background: yellow, likeCount: 10,
                commentCount: 4, comments: [
                    Comment(text: "Whoa. It's weird!"),
                    Comment(text: "Well... I'm speechless :/"),
                    Comment(text: "Wtf"),
                    Comment(text: "Lol :D")
            ]),
            
            Secret(caption: "Here we go", background: red, likeCount: 3, commentCount: 0),
            
            Secret(caption: "There's one thing I've never told anyone about... 10 years ago I...",
                background: green, likeCount: 2, commentCount: 2, comments: [
                    Comment(text: "Hey, so what IS it?!"),
                    Comment(text: "Really? You dropped it half-sentence?")
            ]),
            
            Secret(caption: "This secret is somewhat long though... How will it fit?",
                background: orange, likeCount: 4, commentCount: 1, comments: [
                    Comment(text: "It did fit. OK.")
            ])
        ]
    }
   
}
