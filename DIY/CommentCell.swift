//
//  CommentCell.swift
//  DIY
//
//  Created by Robin Mehta on 8/12/16.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    internal lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = .Center
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "AvenirNext-Medium", size: 22)
        self.contentView.addSubview(titleLabel)
        return titleLabel
    }()
    
    internal lazy var message: UILabel = {
        let detail = UILabel()
        detail.textColor = UIColor.blackColor()
        detail.textAlignment = .Center
        detail.lineBreakMode = .ByWordWrapping
        detail.numberOfLines = 0
        detail.font = UIFont(name: "AvenirNext-Regular", size: 15)
        self.contentView.addSubview(detail)
        return detail
    }()
    
    internal lazy var detail: UILabel = {
        let detail = UILabel()
        detail.textColor = UIColor.grayColor()
        detail.textAlignment = .Center
        detail.lineBreakMode = .ByWordWrapping
        detail.numberOfLines = 0
        detail.font = UIFont(name: "AvenirNext-Regular", size: 12)
        self.contentView.addSubview(detail)
        return detail
    }()
    
    let imgView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func layoutViews() {
        self.contentView.addSubview(imgView)
        
        imgView.pinToLeftEdgeOfSuperview(offset: 10)
        imgView.pinToTopEdgeOfSuperview(offset: 10)
        
        titleLabel.positionToTheRightOfItem(imgView, offset: 10)
        titleLabel.pinTopEdgeToTopEdgeOfItem(imgView)
        
        detail.pinToBottomEdgeOfSuperview(offset: 10)
        detail.pinToRightEdgeOfSuperview(offset: 10)
        
        message.positionBelowItem(titleLabel, offset: 10)
        message.pinLeftEdgeToLeftEdgeOfItem(titleLabel)
        message.sizeToWidth(self.contentView.frame.size.width - 10)
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

