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
        
        let king = Avatar.King
        let av1 = Avatar.Regular(.Planet, .Blue)
        let av2 = Avatar.Regular(.Lightning, .Red)
        let av3 = Avatar.Regular(.Bug, .Green)
        let av4 = Avatar.Regular(.Plug, .Purple)
        let av5 = Avatar.Regular(.Star, .Orange)
        let av6 = Avatar.Regular(.Cat, .Blue)
        
        return [
            Secret(caption: "My first secret...", background: yellow, likeCount: 10,
                commentCount: 4, comments: [
                    Comment(avatar: av1, text: "Whoa. It's weird!"),
                    Comment(avatar: king, text: "It is what it is..."),
                    Comment(avatar: av2, text: "Well... I'm speechless :/"),
                    Comment(avatar: av3, text: "Wtf")
            ]),
            
            Secret(caption: "Here we go", background: red, likeCount: 3, commentCount: 0),
            
            Secret(caption: "There's one thing I've never told anyone about... 10 years ago I...",
                background: green, likeCount: 2, commentCount: 2, comments: [
                    Comment(avatar: av4, text: "Hey, so what IS it?!"),
                    Comment(avatar: av5, text: "Really? You dropped it half-sentence?")
            ]),
            
            Secret(caption: "This secret is somewhat long though... How will it fit?",
                background: orange, likeCount: 4, commentCount: 1, comments: [
                    Comment(avatar: av6, text: "It did fit. OK.")
            ])
        ]
    }
   
}
