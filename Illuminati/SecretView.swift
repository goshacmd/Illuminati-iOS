//
//  SecretView.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/20/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretView: UIView {
    
    // indicates how compact the view is
    // 1 - maximized, 0 - minimized, 0-1 - somewhere in between
    // (used to determine the size of the caption label)
    var compactness: Float = 1
    
    lazy var backgroundView = UIView().noMask()
    lazy var captionLabel: UILabel = UILabel().align(.Center).multiline().noMask()
    lazy var likeCountLabel = UILabel().align(.Right).noMask()
    lazy var commentCountLabel = UILabel().align(.Right).noMask()
    
    lazy var secretTextColor: RACSignal =
        (self.backgroundView ~~ "backgroundColor")
            .ignore(nil)
            .mapAs(self.textColorForBackground)
    
    lazy var secretFontSize: RACSignal =
        (self ~~ "compactness")
            // caption label size is ranging between 14 and 28, depending on compactness
            .map { 14 * (1 + ($0 as Float)) }
    
    lazy var secretFont: RACSignal =
        self.secretFontSize
            .map { UIFont(name: "DamascusBold", size: $0 as CGFloat) }
    
    var disposables: [RACDisposable]

    init(frame: CGRect) {
        disposables = []
        
        super.init(frame: frame)

        addSubview(backgroundView)
        addSubview(captionLabel)
        addSubview(likeCountLabel)
        addSubview(commentCountLabel)
        
        captionLabel.setShadowColor(UIColor.blackColor(), radius: 10, opacity: 0.8)
        
        secretFont ~> RAC(captionLabel, "font")
        
        secretTextColor ~> RAC(captionLabel, "textColor")
        secretTextColor ~> RAC(likeCountLabel, "textColor")
        secretTextColor ~> RAC(commentCountLabel, "textColor")
    }
    
    func bindSecret(_secret: Secret?) {
        for d in disposables {
            d.dispose()
        }
        
        if let secret = _secret {
            disposables = [
                RAC(captionLabel, "text") <~ (secret ~~ "caption"),
                RAC(backgroundView, "backgroundColor") <~ (secret ~~ "background"),
                RAC(likeCountLabel, "text") <~ (secret ~~ "likeCount").map { "L: \($0)" },
                RAC(commentCountLabel, "text") <~ (secret ~~ "commentCount").map { "C: \($0)" }
            ]
        }
        
    }
    
    func textColorForBackground(color: UIColor) -> UIColor {
        return color.oppositeBWColor()
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let views = [
            "caption": captionLabel,
            "likes": likeCountLabel,
            "comments": commentCountLabel,
            "back": backgroundView
        ]
        
        let metrics = [
            "margin": 10,
            "labelSpace": 15
        ]
        
        addOverlayConstraints(backgroundView)
        
        addConstraints("|-(margin)-[caption(>=100)]-(margin)-|" %%% (nil, metrics, views))
        addConstraints("|-(>=0)-[likes]-(labelSpace)-[comments]-(margin)-|" %%% (nil, metrics, views))
        addConstraints("V:|-(margin)-[caption]-(margin)-|" %%% (nil, metrics, views))
        addConstraints("V:[likes]-(margin)-|" %%% (nil, metrics, views))
        addConstraint(NSLayoutConstraint(item: commentCountLabel, attribute: .Baseline, relatedBy: .Equal, toItem: likeCountLabel, attribute: .Baseline, multiplier: 1, constant: 0))
    }

}
