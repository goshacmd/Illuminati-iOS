//
//  UITextField+Builder.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/21/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

extension UITextField {
    func withPlaceholder(placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    func secure() -> Self {
        secureTextEntry = true
        return self
    }
    
    func returnKey(type: UIReturnKeyType) -> Self {
        returnKeyType = type
        return self
    }
    
    func keyboard(type: UIKeyboardType) -> Self {
        keyboardType = type
        return self
    }
    
    func autocap(type: UITextAutocapitalizationType) -> Self {
        autocapitalizationType = type
        return self
    }
    
    func autocorrect(type: UITextAutocorrectionType) -> Self {
        autocorrectionType = type
        return self
    }
    
    func delegateTo(object: UITextFieldDelegate) -> Self {
        delegate = object
        return self
    }
    
    func fontSize(size: Float) -> Self {
        font = UIFont.systemFontOfSize(size)
        return self
    }
}