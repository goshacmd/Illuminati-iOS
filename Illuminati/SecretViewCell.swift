//
//  SecretViewCell.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretViewCell: UITableViewCell {
    
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
        didSet { self.bindSecretToView(secret!) }
    }
    
    var disposables: [RACDisposable] = []

    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        
        backgroundView = UIView()
        selectionStyle = .None
        
        contentView.addSubview(captionLabel)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(commentCountLabel)
        
        secretTextColor ~> RAC(captionLabel, "textColor")
        secretTextColor ~> RAC(likeCountLabel, "textColor")
        secretTextColor ~> RAC(commentCountLabel, "textColor")
    }
    
    func bindSecretToView(secret: Secret) {
        disposables = [
            RAC(captionLabel, "text") <~ (secret ~~ "caption"),
            RAC(backgroundView, "backgroundColor") <~ (secret ~~ "background"),
            RAC(likeCountLabel, "text") <~ (secret ~~ "likeCount").map { "L: \($0)" },
            RAC(commentCountLabel, "text") <~ (secret ~~ "commentCount").map { "C: \($0)" }
        ]
    }
    
    override func prepareForReuse()  {        
        for d in disposables {
            d.dispose()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let views = [
            "caption": captionLabel,
            "likes": likeCountLabel,
            "comments": commentCountLabel
        ]
        
        contentView.addConstraints("|-(margin)-[caption(>=100)]-(margin)-|" %%% (nil, metrics, views))
        contentView.addConstraints("|-(>=0)-[likes]-(labelSpace)-[comments]-(margin)-|" %%% (nil, metrics, views))
        contentView.addConstraints("V:|-(margin)-[caption]-(margin)-|" %%% (nil, metrics, views))
        contentView.addConstraints("V:[likes]-(margin)-|" %%% (nil, metrics, views))
        contentView.addConstraint(NSLayoutConstraint(item: commentCountLabel, attribute: .Baseline, relatedBy: .Equal, toItem: likeCountLabel, attribute: .Baseline, multiplier: 1, constant: 0))
    }
    
    func textColorForBackground(color: UIColor) -> UIColor {
        return color.oppositeBWColor()
    }

}
