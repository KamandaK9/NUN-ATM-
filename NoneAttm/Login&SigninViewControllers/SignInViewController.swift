//
//  SignInViewController.swift
//  NunAtm
//
//  Created by Daniel Senga on 2020/12/30.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class SignInViewController: UIViewController {

    @IBOutlet weak var EmailUIText: UITextField!
    @IBOutlet weak var PasswordUIText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardwhentapped()
        self.ButtonStyles()
        
    }
    
    @IBAction func SignInBtn(_ sender: Any) {
        if let email = EmailUIText.text, let password = PasswordUIText.text {
            LogUser(email: email, password: password)
        }
    }
    
    @IBAction func SignUpBtn(_ sender: Any) {
        let NoAcc = storyboard?.instantiateViewController(withIdentifier: "CreateAccount") as! CreateAccountViewController
        present(NoAcc, animated: true, completion: nil)
    }
    
    @IBAction func PassResetBtn(_ sender: Any) {
        let ForgotPass = storyboard?.instantiateViewController(withIdentifier: "ForgotPass") as! ForgotPasswordViewController
        present(ForgotPass, animated: true, completion: nil)
        
    }
    
    func LogUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] user, error in
            guard self != nil else {return}
            
            if let err = error {
                let alertController = UIAlertController(title: "Whoops", message: "Seems there was an error, try again.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
                self!.display(alertController: alertController)
                
                print("there was an error", err)
            }
            else {
                let alertController = UIAlertController(title: "Success", message: "Click 'OK' to continue", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
                self!.display(alertController: alertController)
            }
            
        }
    }
    
  
    
    func ButtonStyles() {
        
        //borderWidth
        EmailUIText.layer.borderWidth = 0.7
        PasswordUIText.layer.borderWidth = 0.7
       
        
        //CornerRadius
        EmailUIText.layer.cornerRadius = 5
        PasswordUIText.layer.cornerRadius = 5
       
        
        //borderColor
        EmailUIText.layer.borderColor = #colorLiteral(red: 0.1294117647, green: 0.5294117647, blue: 0.007843137255, alpha: 1)
        PasswordUIText.layer.borderColor = #colorLiteral(red: 0.1294117647, green: 0.5294117647, blue: 0.007843137255, alpha: 1)
       
        
    }
                 
    
    func display(alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)

    }
    
           


}


