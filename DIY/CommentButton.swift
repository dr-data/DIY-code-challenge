//
//  CommentButton.swift
//  DIY
//
//  Created by Robin Mehta on 8/13/16.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit

class CommentButton: UIButton {
    
    init(text: String) {
        super.init(frame: CGRectMake(0, 0, 0, 0))
        self.layer.borderColor = Constants.Colors.LightGray.CGColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 3
        self.setTitle(text, forState: UIControlState.Normal)
        self.setTitleColor(Constants.Colors.BrightBlue, forState: UIControlState.Normal)
        self.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 15)
        self.backgroundColor = .whiteColor()
        self.titleLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
