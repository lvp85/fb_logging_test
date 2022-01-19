//
//  ViewController.swift
//  FbloggigAccount
//
//  Created by Udagedara Dehigama on 2022/01/18.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {
// loging label
    @IBOutlet weak var loginButton: UIButton!
    // message label
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Facebook logging details
        updateButton(isLoggedIn: (AccessToken.current != nil))
        updateMessage(with: Profile.current?.name)
    }


    @IBAction func loginButtonTapped(_ sender: Any) {
        let loginManager = LoginManager()
        if let _ = AccessToken.current{
            // Access token available -- user already logged in
            // Perform log out
            
            loginManager.logOut()
            updateButton(isLoggedIn: false)
            updateMessage(with: nil)
            
        }
        else{
            //Access token not available -- user already logged out
            //Perform log in
            loginManager.logIn(permissions: [], from: self) { [weak self] (result,error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                // Check for cancel
                            guard let result = result, !result.isCancelled else {
                                print("User cancelled login")
                                return
                            }
                // Successfully logged in
                           
                            self?.updateButton(isLoggedIn: true)
                            
                           
                            Profile.loadCurrentProfile { (profile, error) in
                                self?.updateMessage(with: Profile.current?.name)
                            }
            }
        }
    }
}
extension ViewController {
    
    private func updateButton(isLoggedIn: Bool) {
        // 1
        let title = isLoggedIn ? "Log out 👋🏻" : "Log in 👍🏻"
        loginButton.setTitle(title, for: .normal)
    }
    
    private func updateMessage(with name: String?) {
        // 2
        guard let name = name else {
            // User already logged out
            messageLabel.text = "Please log in with Facebook."
            return
        }
        
        // User already logged in
        messageLabel.text = "Hello, \(name)!"
    }
}
