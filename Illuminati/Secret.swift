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
    
    init(caption: String, background: UIColor, likeCount: Int, commentCount: Int) {
        self.caption = caption
        self.background = background
        self.likeCount = likeCount
        self.commentCount = commentCount
    }
    
    class func all() -> [Secret] {
        return [
            Secret(caption: "My first secret...", background: UIColor.yellowColor(), likeCount: 10, commentCount: 2),
            Secret(caption: "Here we go", background: UIColor.redColor(), likeCount: 3, commentCount: 0),
            Secret(caption: "This third secret is somewhat long though... How will it fit?", background: UIColor.orangeColor(), likeCount: 4, commentCount: 1)
        ]
    }
   
}
