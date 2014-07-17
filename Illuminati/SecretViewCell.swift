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
    
    var secret: Secret

    init(secret: Secret, style: UITableViewCellStyle, reuseIdentifier: String) {
        self.secret = secret
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundView = UIView()
        selectionStyle = .None
        
        contentView.addSubview(captionLabel)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(commentCountLabel)
        
        RAC(captionLabel, "text") <~ (secret ~~ "caption")
        RAC(backgroundView, "backgroundColor") <~ (secret ~~ "background")
        
        RAC(likeCountLabel, "text") <~ (secret ~~ "likeCount").map { "L: \($0)" }
        RAC(commentCountLabel, "text") <~ (secret ~~ "commentCount").map { "C: \($0)" }
        
        let textColor = (backgroundView ~~ "backgroundColor")
            .ignore(nil)
            .map(^^self.textColorForBackground)
        
        textColor ~> RAC(captionLabel, "textColor")
        textColor ~> RAC(likeCountLabel, "textColor")
        textColor ~> RAC(commentCountLabel, "textColor")
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
