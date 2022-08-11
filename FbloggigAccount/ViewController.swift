//
//  ViewController.swift
//  FbloggigAccount
//
//  Created by Udagedara Dehigama on 2022/01/18.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin

class ViewController: UIViewController {
// loging label
    @IBOutlet weak var loginButton: UIButton!
    // message label
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var btnFbLogOut: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLoadingData: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Facebook logging details
        logingFbfeild()
        
    }

    func logingFbfeild(){
        self.btnFbLogOut.isHidden = true
        self.lblLoadingData.isHidden = true
        self.messageLabel.isHidden = true
        self.lblEmail.isHidden = true
    }
    @IBAction func logoutBtnAction(_ sender: UIButton) {
        
        let logout = LoginManager()
        logout.logOut()
        self.loginButton.isHidden = false
        logingFbfeild()
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.facebookLogin()
        getFacebookData()
    }
    
    // Facebook Login Function
    func facebookLogin() {
        let loginManger = LoginManager()
        loginManger.logIn(permissions: [.publicProfile,.email], viewController: self) { result in
            switch result{
            case .cancelled :
                print("User Click On Cancel Buttion")
            case .failed(let error):
                print(error.localizedDescription)
            case .success(_, _, _):
                self.getFacebookData()
            }
        }
    }
    func fbloaddata(){
        self.loginButton.isHidden = true
        self.btnFbLogOut.isHidden = false
        self.messageLabel.isHidden = false
        self.lblEmail.isHidden = false
        self.lblLoadingData.isHidden = false
    }
    func getFacebookData(){
        if AccessToken.current != nil {
            GraphRequest(graphPath: "me", parameters: ["fields" : "id, email,name, picture.type(large)"]).start { connection, result, error in
                if error == nil {
                    let dict = result as! [String: AnyObject] as NSDictionary
                    let name = dict.object(forKey: "name") as! String
                    let email = dict.object(forKey: "email") as! String
                   
                    
                    print("Name: \(name)")
                    print("Email: \(email)")
                   
                    
                    print(dict)
                    
                    self.messageLabel.text = name
                    self.lblEmail.text = email
                    self.fbloaddata()
                        
                       
                    
                }
                else{
                    print(error?.localizedDescription)
                }
            }
            
        }
        else{
            print("Access Token is NIL")
        }
    }
}
