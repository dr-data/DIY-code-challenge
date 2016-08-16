//
//  PostTableViewCell.swift
//  DIY
//
//  Created by Robin Mehta on 8/13/16.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PostTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var viewControllerDelegate: ViewControllerDelegate? = nil
    var postJSON : AnyObject?
    
    let mediaHeight : CGFloat = 300.00
    
    internal lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        label.text = ""
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        self.contentView.addSubview(label)
        return label
    }()
    
    internal lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.BrightBlue
        label.textAlignment = .Center
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        label.text = ""
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var clearView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.BlueGray
        return view
    }()
    
    private lazy var sendImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "send_icon"))
        imageView.contentMode = .ScaleToFill
        return imageView
    }()
    
    private lazy var commentImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "comment_small"))
        imageView.contentMode = .ScaleToFill
        return imageView
    }()
    
    private lazy var questsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.BrightBlue
        button.layer.cornerRadius = 2
        button.setImage(UIImage(named: "quests_icon"), forState: .Normal)
        self.contentView.addSubview(button)
        return button
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more_icon"), forState: .Normal)
        self.contentView.addSubview(button)
        return button
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart_empty"), forState: .Normal)
        return button
    }()
    
    private lazy var heartFilledButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart_full"), forState: .Normal)
        self.contentView.addSubview(button)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = true
        tableView.hidden = false
        tableView.backgroundColor = UIColor.whiteColor()
        return tableView
    }()
    
    internal lazy var commentButton: CommentButton = {
        let button = CommentButton(text: "Add a comment...")
        button.titleLabel?.textAlignment = .Left
        button.addTarget(self, action: #selector(PostTableViewCell.commentButtonPressed), forControlEvents: .TouchUpInside)
        button.addSubview(self.sendImageView)
        self.sendImageView.pinToRightEdgeOfSuperview(offset: 15)
        self.sendImageView.centerVerticallyInSuperview()
        
        return button
    }()
    
    var numComments : Int?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    
    func layoutViews() {
        dispatch_async(dispatch_get_main_queue()) {
            self.contentView.backgroundColor = Constants.Colors.BlueGray
            self.createPostCard()
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView(frame: CGRectMake(0, 0, self.contentView.frame.size.width - 40, 500))
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.pagingEnabled = true
        scrollView.alwaysBounceVertical = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.layer.cornerRadius = 10
        scrollView.userInteractionEnabled = true
        return scrollView
    }()
    
    private lazy var middleSection: UIView = {
        let middleSection = UIView()
        middleSection.backgroundColor = UIColor.whiteColor()
        return middleSection
    }()
    
    func createPostCard() {
        
        self.titleLabel.pinToTopEdgeOfSuperview(offset: 10)
        self.titleLabel.centerHorizontallyInSuperview()
        self.titleLabel.sizeToWidth(self.contentView.frame.size.width - 30)
        
        self.contentView.addSubview(scrollView)
        scrollView.centerHorizontallyInSuperview()
        scrollView.positionBelowItem(titleLabel, offset: 20)
        scrollView.sizeToHeight(200 + 50 + mediaHeight)
        scrollView.sizeToWidth(self.contentView.frame.size.width - 20)
        scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width - 20, 1000)
        
        scrollView.addSubview(clearView)
        clearView.pinToTopEdgeOfSuperview()
        clearView.sizeToWidth(self.contentView.frame.size.width - 20)
        clearView.sizeToHeight(mediaHeight)
        clearView.centerHorizontallyInSuperview()
        
        scrollView.addSubview(middleSection)
        middleSection.sizeToWidth(self.contentView.frame.size.width - 20)
        middleSection.sizeToHeight(50)
        middleSection.positionBelowItem(clearView)
        middleSection.centerHorizontallyInSuperview()
        middleSection.addSubview(questsButton)
        questsButton.pinToLeftEdgeOfSuperview(offset: 20)
        questsButton.centerVerticallyInSuperview()
        questsButton.sizeToHeight(20)
        questsButton.sizeToWidth(40)
        
        middleSection.addSubview(commentImageView)
        commentImageView.pinToRightEdgeOfSuperview(offset: 20)
        commentImageView.centerVerticallyInSuperview()
        
        middleSection.addSubview(likesLabel)
        likesLabel.positionToTheLeftOfItem(commentImageView, offset: 30)
        likesLabel.centerVerticallyInSuperview()
        
        middleSection.addSubview(heartFilledButton)
        heartFilledButton.positionToTheLeftOfItem(likesLabel, offset: 5)
        heartFilledButton.centerVerticallyInSuperview()
        
        scrollView.addSubview(tableView)
        tableView.positionBelowItem(middleSection)
        tableView.pinToSideEdgesOfSuperview()
        tableView.sizeToWidth(self.contentView.frame.size.width - 20)
        tableView.sizeToHeight(200)
        
        scrollView.addSubview(commentButton)
        commentButton.sizeToWidth(self.contentView.frame.size.width - 20)
        commentButton.sizeToHeight(50)
        commentButton.pinBottomEdgeToBottomEdgeOfItem(self.tableView, offset: 0)
        commentButton.centerHorizontallyInSuperview()
        
    }
    
    // MARK: - Tableview Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numComments = numComments {
            return numComments
        }
        else {return 4}
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "commentCell"
        var cell: CommentCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? CommentCell
        
        if cell == nil {
            cell = CommentCell()
            cell?.selectionStyle = .None
        }
        
//        if (indexPath.row == 0) {
//            cell!.titleLabel.text = "BAK3R"
//            cell!.detail.text = "2 months ago"
//            cell!.message.text = "Oh yum! That looks delicious"
//        }
//        
//        if (indexPath.row == 1) {
//            cell!.titleLabel.text = "Ant Nat"
//            cell!.detail.text = "2 months ago"
//            cell!.message.text = "Thanks😉"
//        }
//        
//        if (indexPath.row == 2) {
//            cell!.titleLabel.text = "Kerri"
//            cell!.detail.text = "Last month"
//            cell?.message.text = "🙀That looks SO SO good! What kind of cake is that? @antnat"
//        }
//        
//        if (indexPath.row == 3) {
//            cell!.titleLabel.text = "Ant Nat"
//            cell!.detail.text = "Last month"
//            cell?.message.text = "It's a chocolate snowball"
//        }
        
        return cell!
    }
    
    func setVideo(url: String) {
        let player = AVPlayer.init(URL: NSURL(string: url)!)
        let layer = AVPlayerLayer()
        layer.player = player
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        layer.frame = CGRectMake(0, 0, self.contentView.frame.size.width - 20, mediaHeight)
        layer.backgroundColor = UIColor.clearColor().CGColor
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        
        // weak self?
        dispatch_async(dispatch_get_main_queue()) {
                self.scrollView.layer.addSublayer(layer)
                player.play()
        }
    }
    
    func setMainImage(url: String) {
        
        let realURL = NSURL(string: url)
        let data = NSData(contentsOfURL: realURL!)
        let image = UIImage(data: data!)
        
        let imageView = UIImageView(image: image)
        
        // weak self first?
        dispatch_async(dispatch_get_main_queue()) {
                self.scrollView.addSubview(imageView)
                imageView.pinToTopEdgeOfSuperview()
                imageView.pinToSideEdgesOfSuperview()
                imageView.sizeToHeight(self.mediaHeight)
                imageView.sizeToWidth(self.contentView.frame.size.width - 20)
                imageView.contentMode = .ScaleToFill
        }
    }
    
    func commentButtonPressed() {
        if let postJSON = postJSON {
            let postID = dataClass.sharedInstance.getPostIDfromJSON(postJSON)
            viewControllerDelegate?.showViewController(postID)
        }
    }
    
    func fillHeart() {
        self.heartButton.addSubview(UIImageView(image: UIImage(named: "heart_full")))
    }

    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
