//
//  SecretViewCell.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretViewCell: UITableViewCell {
    
    @lazy var captionLabel: UILabel = {
        let label = UILabel().noMask()
        label.textAlignment = .Center
        label.font = UIFont(name: "DamascusBold", size: 28)
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        return label
    }()

    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundView = UIView()
        selectionStyle = .None
        
        contentView.addSubview(captionLabel)
        
        RAC(captionLabel, "textColor") <~ (backgroundView ~~ "backgroundColor")
            .ignore(nil)
            .map(^^self.textColorForBackground)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let metrics = [ "margin": 30 ]
        let views = [ "caption": captionLabel ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-(margin)-[caption(>=100)]-(margin)-|", options: nil, metrics: metrics, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(margin)-[caption]-(margin)-|", options: nil, metrics: metrics, views: views))
        contentView.addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .Height, relatedBy: .Equal, toItem: captionLabel, attribute: .Width, multiplier: 1, constant: 0))

    }
    
    func textColorForBackground(color: UIColor) -> UIColor {
        return color.oppositeBWColor()
    }

}
