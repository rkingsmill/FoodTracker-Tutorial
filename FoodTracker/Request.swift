//
//  Request.swift
//  FoodTracker
//
//  Created by Rosalyn Kingsmill on 2016-06-06.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class Request: NSObject {
    
    var token: String?

    func signUpToken(user: User, completionHandler: (token: String, error: String?)->Void) {
        //declare parameter as a dictionary which contains string as key and value combination.
        let parameters = ["username": user.username, "password": user.password] as Dictionary<String, String>
        
        //create the url with NSURL
        let url = NSURL(string: "http://159.203.243.24:8000/signup") //change the url
        
        //create the session object
        let session = NSURLSession.sharedSession()
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST" //set http method as POST
        
        //what type of content sending and receiving
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonData = try? NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
        request.HTTPBody = jsonData
        //create dataTask using the session object to send data to the server
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            print("Error: \(error)")
            if (error == nil)
            {
                if data != nil {
                if let response = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary {
                    let errorValue = response!["error"] as! String?;
                    
                    if (errorValue == nil) {
                        let userDictionary = response!["user"]
                        self.token = userDictionary!["token"] as? String
                        completionHandler(token: self.token!, error: error?.localizedDescription)
                    }
                    else
                    {
                        completionHandler(token: "", error: errorValue);
                    }
                    } }
            }
            //connection error
            else
            {
                completionHandler(token: "", error: error?.localizedDescription);
            }
            
        })
        task.resume()
        
    }
    
    
    func loginToken(user: User, completionHandler: (token: String, error: String?)->Void) {
        //declare parameter as a dictionary which contains string as key and value combination.
        let parameters = ["username": user.username, "password": user.password] as Dictionary<String, String>
        
        //create the url with NSURL
        let url = NSURL(string: "http://159.203.243.24:8000/login")
        
        //create the session object
        let session = NSURLSession.sharedSession()
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST" //set http method as POST
        
        //what type of content sending and receiving
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonData = try? NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
        request.HTTPBody = jsonData
        //create dataTask using the session object to send data to the server
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            print("Error: \(error)")
            if (error == nil)
            {
                if data != nil {
                    if let response = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary {
                        let errorValue = response!["error"] as! String?;
                        
                        if (errorValue == nil) {
                            let userDictionary = response!["user"]
                            self.token = userDictionary!["token"] as? String
                            completionHandler(token: self.token!, error: error?.localizedDescription)
                        }
                        else
                        {
                            completionHandler(token: "", error: errorValue);
                        }
                    } }
            }
                //connection error
            else
            {
                completionHandler(token: "", error: error?.localizedDescription);
            }
            
        })
        task.resume()
        
    }
    
}