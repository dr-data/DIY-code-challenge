//
//  Constants.swift
//  DIY
//
//  Created by Robin on 8/12/16.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Constants {
    struct Colors {
        static let BlueGray = UIColor(red:0.21, green:0.27, blue:0.31, alpha:1.0)
        static let BrightBlue = UIColor(red:0.33, green:0.42, blue:1.00, alpha:1.0)
        static let LightGray = UIColor(red:0.84, green:0.86, blue:0.87, alpha:1.0)
    }
    
    struct Keys {
        static let getURL = "https://api-staging.jam.com/posts?num_comments=0&limit=20&offset=0"
        static let headerField = "x-diy-api-token"
        static let headerValue = "aa13390c154eb2ac4242268c66fe354c6ef93c2d"
        static let postURL = "https://api-staging.jam.com/comments"
        static let contentType = "Content-Type"
        static let contentTypeValue = "application/json"
    }
}

public protocol DataDelegate {
    func passJSON(json: AnyObject)
}

public protocol ViewControllerDelegate {
    func showViewController(postID: NSNumber)
}

public class dataClass {
    var dataDelegate: DataDelegate? = nil
    
    func nsdataToJSON(data: NSData) -> AnyObject? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
    
    func getPosts() {
        let url = NSURL(string: Constants.Keys.getURL)
        let request = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        request.setValue(Constants.Keys.headerValue, forHTTPHeaderField: Constants.Keys.headerField)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if let jsonData = self.nsdataToJSON(data!) {
                self.dataDelegate?.passJSON(jsonData)
            }
            
        }).resume()
    }
    
    func getCaption(json: AnyObject, index: Int) -> String {
        
        let json = JSON(json)
        
        if let response = json["response"][index]["caption"].string {
            if (response != "Optional(<null>)") {
                return response
            }
            else {
                return ""
            }
        }
        else {
            return ""
        }
    }
    
    func getNumComments(json: AnyObject, index: Int) -> Int {
        
        let json = JSON(json)
        
        if let response = json["response"][index]["num_comments"].int {
            return response
        }
        else {
            return 0
        }
    }
    
    func getPostJSON(json: AnyObject, index: Int) -> AnyObject? {
        let json = JSON(json)
        if let response = json["response"][index].dictionaryObject {
            return response
        }
        else {
            return nil
        }
    }
    
    func getPostIDfromJSON(json: AnyObject) -> NSNumber {
        
        let json = JSON(json)
        if let response = json["id"].number {
            return response
        }
        else {
            return 0
        }
    }
    
    func makePostRequest(postID: NSNumber, comment: String) {
        let json = ["post_id": postID, "text": comment]
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            let url = NSURL(string: Constants.Keys.postURL)
            let request = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
            request.setValue(Constants.Keys.headerValue, forHTTPHeaderField: Constants.Keys.headerField)
            request.setValue(Constants.Keys.contentTypeValue, forHTTPHeaderField: Constants.Keys.contentType)
            request.HTTPMethod = "POST"
            request.HTTPBody = jsonData
            
            let session = NSURLSession.sharedSession()
            session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
                if error != nil {
                    print("Error -> \(error)")
                    return
                }
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                    print("Result -> \(result)")
                } catch {
                    print("Error -> \(error)")
                }
                
            }).resume()
            
        } catch {
            print(error)
        }
    }
    
    func getMediaTypefromJSON(json: AnyObject, index: Int) -> String {
        let json = JSON(json)
        if let response = json["response"][index]["media"]["type"].string {
            return response
        }
        else {
            return ""
        }

    }
    
    func getMediaURLfromJSON(json: AnyObject, index: Int) -> String {
        let json = JSON(json)
        if let response = json["response"][index]["media"]["small"].string {
            return response
        }
        else {
            return ""
        }
    }
    
    func getNumLikes(json: AnyObject, index: Int) -> NSNumber {
        let json = JSON(json)
        if let response = json["response"][index]["num_likes"].number {
            return response
        }
        else {
            return 0
        }
    }
}

