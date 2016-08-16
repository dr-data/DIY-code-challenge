//
//  ViewController.swift
//  DIY
//
//  Created by Robin Mehta on 8/12/16.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, DataDelegate, ViewControllerDelegate {
    
    // MARK: - UI Components
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.layer.opacity = 1
        button.setImage(UIImage(named: "close"), forState: .Normal)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = true
        tableView.hidden = false
        tableView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tableView)
        return tableView
    }()

    var jSON : AnyObject?
    var viewControllerDelegate: ViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Colors.BlueGray
        self.navigationController?.navigationBarHidden = true
        dataClass.sharedInstance.dataDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (dataClass.sharedInstance.jSON == nil) {
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                dataClass.sharedInstance.getPosts()
            }
        }
        else {
            self.jSON = dataClass.sharedInstance.jSON
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        LayoutViews()
    }
    
    func LayoutViews() {
        tableView.pinToEdgesOfSuperview()
        tableView.sizeToHeight(self.view.frame.size.height)
        tableView.sizeToWidth(self.view.frame.size.width)
        
        closeButton.pinToTopEdgeOfSuperview(offset: 25)
        closeButton.pinToLeftEdgeOfSuperview(offset: 15)
    }

    // MARK: - Tableview Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return false
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.size.height
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "postCell"
        var cell: PostTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? PostTableViewCell
        
        if cell == nil {
            cell = PostTableViewCell()
            cell?.selectionStyle = .None
        }
        
        if let cell = cell {
            cell.viewControllerDelegate = self
            if let loadedJSON = jSON { // to not have to check in model
                cell.postJSON = dataClass.sharedInstance.getPostJSON(indexPath.row)
                let cellTitle = dataClass.sharedInstance.getCaption(indexPath.row)
                cell.numComments = dataClass.sharedInstance.getNumComments(indexPath.row)
                cell.likesLabel.text = dataClass.sharedInstance.getNumLikes(indexPath.row).stringValue
                
                let mediaType = dataClass.sharedInstance.getMediaTypefromJSON(indexPath.row)
                let mediaString = dataClass.sharedInstance.getMediaURLfromJSON(indexPath.row)
                
                if (mediaType == "image") {
                    cell.setMainImage(mediaString)
                }
                else {
                    cell.setVideo(mediaString)
                }
                cell.titleLabel.text = cellTitle
            }
        }

        return cell!
    }
    
    func passJSON(json: AnyObject) {
        jSON = json
        dispatch_async(dispatch_get_main_queue()) { 
            self.tableView.reloadData() 
        }
    }
    
    func showViewController(postID: NSNumber) {
        self.presentViewController(CannedResponsesViewController(postID: postID), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

