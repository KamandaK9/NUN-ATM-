//
//  SignUpViewController.swift
//  NunAtm
//
//  Created by Daniel Senga on 2020/12/30.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage




class SignUpViewController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var avatar: UIImageView!
    var image : UIImage? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardwhentapped()
        self.ButtonStyles()
        self.setupAvatar()
        
       
        
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if let name = NameTextField.text, let email = EmailTextField.text, let password = PasswordTextField.text {
            createUser(name: name, email: email, password: password)
        }
        
    
   }
    
    @IBAction func SignInBtn(_ sender: Any) {
        let Signin = storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        present(Signin, animated: true, completion: nil)
        
        
    }
    
    func ButtonStyles() {
        
        //borderWidth
        NameTextField.layer.borderWidth = 0.7
        EmailTextField.layer.borderWidth = 0.7
        PasswordTextField.layer.borderWidth = 0.7
        
        //CornerRadius
        NameTextField.layer.cornerRadius = 5
        EmailTextField.layer.cornerRadius = 5
        PasswordTextField.layer.cornerRadius = 5
        
        //borderColor
        NameTextField.layer.borderColor = #colorLiteral(red: 0.1294117647, green: 0.5294117647, blue: 0.007843137255, alpha: 1)
        EmailTextField.layer.borderColor = #colorLiteral(red: 0.1294117647, green: 0.5294117647, blue: 0.007843137255, alpha: 1)
        PasswordTextField.layer.borderColor = #colorLiteral(red: 0.1294117647, green: 0.5294117647, blue: 0.007843137255, alpha: 1)
        
    }
    
    
    
    
    func createUser(name: String, email: String, password: String) {
        
        guard let imageSelected = self.image else {
            print("Avatar is nill")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            
            return
        }
       
        Auth.auth().createUser(withEmail: email, password: password) { (AuthDataResult, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let authData = AuthDataResult {
                print(authData.user.email)
                var dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "profileImageURL": "",
                    "name": self.NameTextField.text
                ]
                
                let storageRef = Storage.storage().reference(forURL: "gs://notatm-1561121206882.appspot.com")
                let storageProfileRef = storageRef.child("profile").child(authData.user.uid)
                
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                storageProfileRef.putData(imageData, metadata: metadata, completion: {(StorageMetadata, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    storageProfileRef.downloadURL { (url, error) in
                        if let metaImageUrl = url?.absoluteString {
                            dict["profileImageURL"] = metaImageUrl
                            
                            Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: {(error, ref) in if error == nil {
                                print("Done")
                                
                               // self.ShowProfile()
                               
                        }
                    })
                }
                
                
               
                        /*    let alertController = UIAlertController(title: "Success", message: "Profile Created", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
                            self.display(alertController: alertController) */
                            
                             }
                         })
                    }
                }
         }
    
    
                func display(alertController: UIAlertController) {
                    present(alertController, animated: true, completion: nil)
                }
    
    func ShowProfile() {
        let Profile = storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        self.present(Profile, animated: true, completion: nil)
    }
    
    
    func setupAvatar() {
        avatar.layoutIfNeeded()
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.layer.borderWidth = 2
        avatar.layer.borderColor = #colorLiteral(red: 0.1294117647, green: 0.5294117647, blue: 0.007843137255, alpha: 1)
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
                
    
    
    }

    

extension UIViewController {
    func hideKeyboardwhentapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            avatar.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage {
            image = imageOriginal
            avatar.image = imageOriginal
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}


