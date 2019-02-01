//
//  ViewController.swift
//  SocialFLogin
//
//  Created by Apple on 11/22/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    var dict : [String : AnyObject]!
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func fbLogin(_ sender: Any) {
           fbLoginManager.loginBehavior = FBSDKLoginBehavior.web
        if let aString = URL(string: "fb://") {
            if UIApplication.shared.canOpenURL(aString) {
                fbLoginManager.loginBehavior = FBSDKLoginBehavior.systemAccount
            }
        }
        fbLoginManager.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        if((FBSDKAccessToken.current()) != nil){
                            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                                if (error == nil){
                                    self.dict = result as? [String : AnyObject]
                                    print(result!)
                                    print(self.dict!)
                                }
                            })
                        }
    
                    }
                }
            }else{
                // provide alert for that
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    @IBAction func fbLogout(_ sender: Any) {
        print("logout from facebook.")
        fbLoginManager.logOut()
    }
    
    
}

