//
//  CreateAccountViewController.swift
//  NunAtm
//
//  Created by Daniel Senga on 2020/12/31.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import FirebaseAuth
import Firebase

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var FBLogin: FBLoginButton!
    var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observe access token changes
        // This will trigger after successfully login / logout
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
        
        //Overriding the standard Facebook button height
        updateFbButton()
        
        //GoogleSignIn
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        
        DispatchQueue.main.async {
            // Register notification to update screen after user successfully signed in
            NotificationCenter.default.addObserver(self,selector: #selector(self.userDidSignInGoogle(_:)),name: .signInGoogleCompleted,object: nil)
        }
        
        Loading()
        
    }
    
    
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        updateScreen()
      
        }
    

   private func updateScreen() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        if (GIDSignIn.sharedInstance()?.currentUser) != nil {
            let Loggedin = self.storyboard?.instantiateViewController(withIdentifier: "SelectATM") as! SelectATMViewController
            DispatchQueue.main.async {
                self.present(Loggedin, animated: true, completion: nil)
            }
            self.activityIndicator.startAnimating()
        }
    }
}
    
    func Loading() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @IBAction func GoogleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    @IBAction func CreateAccBtn(_ sender: Any) {
        let CreateAcc = storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        present(CreateAcc, animated: true, completion: nil)
    }
    
    func updateFbButton() {
        for constraint in FBLogin.constraints where constraint.firstAttribute == .height {
            constraint.constant = 47
        }

    }

}

