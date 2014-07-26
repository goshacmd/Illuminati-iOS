//
//  Comment.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/20/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import Foundation

enum AvatarObject: String {
    case Skull     = "skull"
    case Tree      = "tree"
    case Cat       = "cat"
    case Owl       = "owl"
    case Shirt     = "shirt"
    case Planet    = "planet"
    case Pile      = "pile"
    case Puzzle    = "puzzle"
    case Ghost     = "ghost"
    case Lightning = "lightning"
    case Bone      = "bone"
    case Star      = "star"
    case Droid     = "droid"
    case Bug       = "bug"
    case IceCream  = "ice-cream"
    case Plug      = "plug"
}

enum AvatarColor: String {
    case Red    = "red"
    case Green  = "green"
    case Blue   = "blue"
    case Purple = "purple"
    case Orange = "orange"
    
    func uicolor() -> UIColor {
        switch self {
        case .Red:    return UIColor.redColor()
        case .Green:  return UIColor.greenColor()
        case .Blue:   return UIColor.blueColor()
        case .Purple: return UIColor.purpleColor()
        case .Orange: return UIColor.orangeColor()
        }
    }
}

enum Avatar {
    case Regular(AvatarObject, AvatarColor)
    case King
    
    func background() -> UIColor {
        switch self {
        case let .Regular(object, color): return color.uicolor()
        case     .King:                   return UIColor.blackColor()
        }
    }
    
}

class Comment: NSObject {
    
    var avatar: Avatar
    var text: String
    
    init(avatar: Avatar, text: String) {
        self.avatar = avatar
        self.text = text
    }
    
}
