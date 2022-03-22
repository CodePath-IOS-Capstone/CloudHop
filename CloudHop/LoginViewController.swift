//
//  LoginViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 3/21/22.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    let db = Firestore.firestore()
    var userEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // TESTING FUNCTIONS
        
        //        signUp(email: "test@gmail.com", password: "testing", name: "test", country: "USA")
        //        signOut()
                signIn(email: "test3@gmail.com", password: "testing")
                getLoggedInUser()
                
                // testing document gets and posts
        //        createNewUserDocument(data: ["name": "Carlos", "email": "test@gmail.com", "country": "USA"])
//                if FirebaseAuth.Auth.auth().currentUser != nil {
//                    addLikedLocation(location: "New York", data: ["email": userEmail])
//                    getLikedLocations(email: userEmail)
//                }
        //        addLikedLocation(location: "New York", data: ["email": "test@gmail.com"])
        //        getDoc(collection: "users", document: "Carlos")
        //        getLikedLocations(email: test@gmail.com)
                print(userEmail)
        
    }
    
    /*
    Function to create an account and sign up with email and password. Creates the user document once the user is signed up
    */
    func signUp(email: String, password: String, name: String, country: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("There was an error.")
                return
            }
            // save user email, name and country into doc under email
            self?.createNewUserDocument(data: ["name" : name, "email" : email, "country" : country])
            print("Signed in")
            
        })
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
                return
            }
            print("Signed in")
        })
    }
    
    /*
    Function to sign out the current user.
    */
    func signOut () {
        do {
            try FirebaseAuth.Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }

    }
    
    /*
    Function to get the current users email and save it in userEmail. Used when fetching information about the user from firestore.
    */
    // TODO: This function does not go here. Place in correct files later. Used anywhere we need to get the current user
    func getLoggedInUser() {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            userEmail = FirebaseAuth.Auth.auth().currentUser!.email!
        } else {
            print("Not signed in.")
        }
    }
    
    /*
    Create a new user in the users collection. Call on user account creation
    */
    func createNewUserDocument(data: NSDictionary) {
        
        let name = data["name"] as! String
        let email = data["email"] as! String
        let country = data["country"] as! String
//        let createdAt = data["createdAt"] as! Date
        
        let documentRef = db.document("users/\(email)")

        // TODO: add the createdAt date
        documentRef.setData(["name": name, "email": email, "country": country])
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
