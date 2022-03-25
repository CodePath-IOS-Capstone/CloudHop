//
//  HomeScreenViewController.swift
//  CloudHop
//
//  Created by Eva Sennrich on 3/25/22.
//

import UIKit
import FirebaseAuth

class HomeScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        signOut()
    }
    
    /*
    Function to sign out the current user.
    */
    func signOut () {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            print("Signed out.")
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }

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
