//
//  CannedResponsesViewController.swift
//  DIY
//
//  Created by Robin Mehta on 8/12/16.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit

class CannedResponsesViewController: UIViewController {
    
    let postId : NSNumber
    
    // MARK: - Init
    
    init(postID: NSNumber) {
        self.postId = postID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal lazy var commentButton: CommentButton = {
        let button = CommentButton(text: "Hey @username! Nice to meet you, welcome to JAM!")
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(CannedResponsesViewController.commentButtonPressed), forControlEvents: .TouchUpInside)
        return button
    }()
    
    internal lazy var commentButton2: CommentButton = {
        let button = CommentButton(text: "Whoa, @username! This is awesome!")
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(CannedResponsesViewController.commentButtonPressed2), forControlEvents: .TouchUpInside)
        return button
    }()
    
    internal lazy var commentButton3: CommentButton = {
        let button = CommentButton(text: "Welcome to JAM @username! We’re so happy you’ve joined us. I’m Kelsey and I’m part of the JAM mod team. I am here to give you feedback and answer your questions. The other JAM mods are Kerri, Becky, John, and Chalon. Here’s a few tips to help you get the most out of your course: It’s fine to skip steps. You can return to them later if you wish. A fast way to to make friends is to comment on other Jammer’s posts. If you put the @ symbol in front of their JAM name they will get a notification with your feedback! For safety reasons never reveal your personal contact information here. You’re now ready to JAM!")
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(CannedResponsesViewController.commentButtonPressed3), forControlEvents: .TouchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Colors.BlueGray
        self.navigationController?.navigationBarHidden = true
        
        commentButton.pinToTopEdgeOfSuperview(offset: 20)
        commentButton.centerHorizontallyInSuperview()
        commentButton.sizeToWidth(self.view.frame.size.width - 30)
        commentButton.sizeToHeight(100)
        commentButton.titleLabel?.sizeToWidth(self.view.frame.size.width - 70)
        
        commentButton2.positionBelowItem(commentButton, offset: 20)
        commentButton2.centerHorizontallyInSuperview()
        commentButton2.sizeToWidth(self.view.frame.size.width - 30)
        commentButton2.sizeToHeight(100)
        commentButton2.titleLabel?.sizeToWidth(self.view.frame.size.width - 70)
        
        commentButton3.positionBelowItem(commentButton2, offset: 20)
        commentButton3.centerHorizontallyInSuperview()
        commentButton3.sizeToWidth(self.view.frame.size.width - 30)
        commentButton3.sizeToHeight(400)
        commentButton3.titleLabel?.sizeToWidth(self.view.frame.size.width - 70)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func commentButtonPressed() {
        dataClass.sharedInstance.makePostRequest(postId, comment: (commentButton.titleLabel?.text)!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func commentButtonPressed2() {
        dataClass.sharedInstance.makePostRequest(postId, comment: (commentButton2.titleLabel?.text)!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func commentButtonPressed3() {
        dataClass.sharedInstance.makePostRequest(postId, comment: (commentButton3.titleLabel?.text)!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
