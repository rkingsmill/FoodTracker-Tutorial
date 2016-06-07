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
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    @IBAction func loginUser(sender: AnyObject) {
        
        let user = User(username: usernameTextField.text!, password: passwordTextField.text!)
        let request = Request()
        request.loginToken(user, completionHandler: {(token, error) in
            user.token = token
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.errorLabel.text = error;
                })
            }
            else {
                
                //set user defaults
                let prefs = NSUserDefaults.standardUserDefaults()
                prefs.setValue(user.token, forKey: "token")
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.navigationController?.popViewControllerAnimated(true)
                    
                })
            }
        })
    }
    
    @IBAction func signUpUser(sender: AnyObject) {
        
        if self.passwordTextField.text!.characters.count < 8 {
            self.errorLabel.text = "Please enter a password that is a minimum of 8 characters"
        }
        
        else {
            let user = User(username: usernameTextField.text!, password: passwordTextField.text!)
            let request = Request()
            request.signUpToken(user, completionHandler: { (token, error) in
                user.token = token
                if (error != nil) {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.errorLabel.text = error;
                    })
                }
                else {

                    //set user defaults
                    let prefs = NSUserDefaults.standardUserDefaults()
                    prefs.setValue(user.token, forKey: "token")
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                    
                }
                
            })
            
        }
    }
    
}