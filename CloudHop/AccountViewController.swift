//
//  AccountViewController.swift
//  CloudHop
//
//  Created by Eva Sennrich on 3/24/22.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore

extension UITextField {
func setIcon(_ image: UIImage) {
   let iconView = UIImageView(frame:
                  CGRect(x: 10, y: 5, width: 20, height: 20))
   iconView.image = image
   let iconContainerView: UIView = UIView(frame:
                  CGRect(x: 20, y: 0, width: 30, height: 30))
   iconContainerView.addSubview(iconView)
   leftView = iconContainerView
   leftViewMode = .always
}
}
class AccountViewController: UIViewController {

    let db = Firestore.firestore()
    var userEmail = ""
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    @IBOutlet weak var singInBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //This code gives shadow to the singIn Button
        singInBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        singInBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        singInBtn.layer.shadowOpacity = 1.0
        singInBtn.layer.shadowRadius = 0.0
        singInBtn.layer.masksToBounds = false
        singInBtn.layer.cornerRadius = 4.0


        // Do any additional setup after loading the view.
        
        //This code add UI icon in Login textFields
        //emailField.setIcon(imageLiteral(resourceName: "user"))
        //imageLiteral(resourceName: "icon-user") this is a new Xcode’s functionality where it allows you to use image asset’s name in replacement of UIImage(named: "icon-user"). This allows you to view the image resource in real-time on the editor itself.
        
        emailField.setIcon(UIImage(named: "user")!)
        emailField.tintColor = UIColor.lightGray
        passwordField.setIcon(UIImage(named: "password")!)
        passwordField.tintColor = UIColor.lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "homeScreenSegue", sender: self)
        }
    }
    
    
    @IBAction func signInUser(_ sender: Any) {
        signIn(email: emailField.text!, password: passwordField.text!)
        
    }
    
    @IBAction func signUpUser(_ sender: Any) {
        // takes the user to the register page
                self.performSegue(withIdentifier: "SignUpSegue", sender: nil)

    }
    
   
        
    
    /*
    Function to sign in to an existing user account with email and password
    */
    func signIn(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
//                strongSelf.showCreateAccount() // could not sign in, no account exists.
                print("Error, no user exists.")
                return
            }
            print("Signed in")
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            UserDefaults.standard.set(email, forKey: "loggedInEmail")
            self!.performSegue(withIdentifier: "homeScreenSegue", sender: nil)
        })
        
        
//        if FirebaseAuth.Auth.auth().currentUser != nil {
//            userEmail = FirebaseAuth.Auth.auth().currentUser!.email!
//            self.performSegue(withIdentifier: "homeScreenSegue", sender: nil)
//        } else {
//            print("Not signed in.")
//        }
    }
        
        
        
        
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//          guard let strongSelf = self else { return
//            if user != nil {
//                self.performSegue(withIdentifier: "homeScreenSegue", sender: nil)
//            } else {
//                print("error")
//            }
//        }
//        }
        

    
    
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "homeScreenSegue" else { return }
        UserUtil.userEmail = UserDefaults.standard.string(forKey: "loggedInUser") ?? emailField.text!
    }

}

