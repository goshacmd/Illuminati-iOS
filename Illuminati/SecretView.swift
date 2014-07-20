//
//  SecretView.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/20/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretView: UIView {
    
    let metrics = [
        "margin": 30,
        "labelSpace": 15
    ]
    
    @lazy var captionLabel: UILabel = {
        let label = UILabel().noMask()
        label.textAlignment = .Center
        label.font = UIFont(name: "DamascusBold", size: 28)
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    @lazy var likeCountLabel: UILabel = {
        let label = UILabel().noMask()
        label.textAlignment = .Right
        return label
    }()
    
    @lazy var commentCountLabel: UILabel = {
        let label = UILabel().noMask()
        label.textAlignment = .Right
        return label
    }()
    
    @lazy var secretTextColor: RACSignal =
        (self.backgroundView ~~ "backgroundColor")
            .ignore(nil)
            .map(^^self.textColorForBackground)
    
    var secret: Secret? {
        didSet { self.bindSecretToView(secret) }
    }
    
    var backgroundView: UIView
    
    var disposables: [RACDisposable]

    init(frame: CGRect) {
        backgroundView = UIView().noMask()
        disposables = []
        
        super.init(frame: frame)

        addSubview(backgroundView)
        addSubview(captionLabel)
        addSubview(likeCountLabel)
        addSubview(commentCountLabel)
        
        secretTextColor ~> RAC(captionLabel, "textColor")
        secretTextColor ~> RAC(likeCountLabel, "textColor")
        secretTextColor ~> RAC(commentCountLabel, "textColor")
    }
    
    func bindSecretToView(_secret: Secret?) {
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
        
        addConstraints("|[back]|" %%% (nil, nil, views))
        addConstraints("V:|[back]|" %%% (nil, nil, views))
        
        addConstraints("|-(margin)-[caption(>=100)]-(margin)-|" %%% (nil, metrics, views))
        addConstraints("|-(>=0)-[likes]-(labelSpace)-[comments]-(margin)-|" %%% (nil, metrics, views))
        addConstraints("V:|-(margin)-[caption]-(margin)-|" %%% (nil, metrics, views))
        addConstraints("V:[likes]-(margin)-|" %%% (nil, metrics, views))
        addConstraint(NSLayoutConstraint(item: commentCountLabel, attribute: .Baseline, relatedBy: .Equal, toItem: likeCountLabel, attribute: .Baseline, multiplier: 1, constant: 0))
    }

}
