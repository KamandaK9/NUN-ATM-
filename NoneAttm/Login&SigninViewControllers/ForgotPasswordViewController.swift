//
//  ForgotPasswordViewController.swift
//  NunAtm
//
//  Created by Daniel Senga on 2021/01/03.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var EmailUIText: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var LblResetMess: UILabel!
    
    @IBAction func OnPassReset(_ sender: Any) {
        if let email = EmailUIText.text {
        callResetpass(email: email)
        }
    }
    
    @IBAction func OnBackBtn(_ sender: Any) {
        let BackBtn = storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        present(BackBtn, animated: true, completion: nil)
    }
    
    func callResetpass(email: String) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            DispatchQueue.main.async {
                
                if error != nil {
                    self.LblResetMess.text = "Your email was not found"
                    self.LblResetMess.textColor = #colorLiteral(red: 0.8824861646, green: 0, blue: 0, alpha: 1)
                    
                }
                else {
                    self.LblResetMess.text = "We sent you an email with instructions on how to reset your password."
                    self.LblResetMess.textColor = #colorLiteral(red: 0, green: 0.8187524676, blue: 0, alpha: 1)
                }
             }
        }
    }

}
