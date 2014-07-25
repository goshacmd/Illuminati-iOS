//
//  Comment.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/20/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import Foundation

enum AvatarObject: Int {
    case Skull, Tree, Cat, Owl, Shirt, Planet, Pile, Puzzle, Ghost, Lightning, Bone, Star, Droid,
         Bug, IceCream, Plug
}

enum AvatarColor: Int {
    case Red, Green, Blue, Violet, Orange
}

enum Avatar {
    case Regular(AvatarObject, AvatarColor)
    case King
}

class Comment: NSObject {
    
    var avatar: Avatar
    var text: String
    
    init(avatar: Avatar, text: String) {
        self.text = text
    }
    
}
