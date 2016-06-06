//
//  SignInViewController.swift
//  FoodTracker
//
//  Created by Rosalyn Kingsmill on 2016-06-06.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    
    // MARK: Properties
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func signUpUser(sender: AnyObject) {
        
        if self.passwordTextField.text!.characters.count < 8 {
            print ("Please enter a password that is a minimum of 8 characters")
        }
        else {
            let user = User(username: usernameTextField.text!, password: passwordTextField.text!)
            let request = Request()
            request.signUpToken(user, completionHandler: { (token) in
                user.token = token
                
                //set user defaults
                let prefs = NSUserDefaults.standardUserDefaults()
                prefs.setValue(user.username, forKey: "username")
                prefs.setValue(user.password, forKey: "password")
                prefs.setValue(user.token, forKey: "token")
                
                self.navigationController?.popViewControllerAnimated(true)
            })
            
        }
    }
    
}