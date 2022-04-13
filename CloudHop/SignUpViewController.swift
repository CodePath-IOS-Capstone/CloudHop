//
//  SignUpViewController.swift
//  CloudHop
//
//  Created by Eva Sennrich on 3/24/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let db = Firestore.firestore()
    var countries: [String] = ["United States"]
   
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }

        // Do any additional setup after loading the view.

        // self.view.backgroundColor = UIColor.red
        
        //This code gives shadow to signUp btn
        signUpBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        signUpBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        signUpBtn.layer.shadowOpacity = 1.0
        signUpBtn.layer.shadowRadius = 0.0
        signUpBtn.layer.masksToBounds = false
        signUpBtn.layer.cornerRadius = 4.0

        pickerView.delegate = self
        pickerView.dataSource = self
        
        countryField.inputView = pickerView
//        self.view.backgroundColor = UIColor.red
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryField.text = countries[row]
        countryField.resignFirstResponder()
    }
    
    
    
    
    @IBAction func SignUp(_ sender: Any) {
        
        signUpUser(email: emailField.text!, password: passwordField.text!, name: nameField.text!, country: countryField.text!)
    
    }
    
    @IBAction func SignIn(_ sender: Any) {
//        self.performSegue(withIdentifier: "signInAlreadyHaveAccount", sender: nil)
    }
    
    /*
    Function to create an account and sign up with email and password. Creates the user document once the user is signed up
    */
    func signUpUser(email: String, password: String, name: String, country: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("There was an error.")
                return
            }
//             save user email, name and country into doc under email
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            UserDefaults.standard.set(email, forKey: "loggedInEmail")
            self?.createNewUserDocument(data: ["name" : name, "email" : email, "country" : country])
            UserUtil.setRandomPicture(email: email)
            self?.performSegue(withIdentifier: "preferenceSegue", sender: nil)
            print("Signed in")
            
        })
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        guard segue.identifier == "preferenceSegue" else { return }
        UserUtil.userEmail = UserDefaults.standard.string(forKey: "loggedInUser") ?? emailField.text!
//        UserUtil.addLikedLocation(location: "Adelaide")
        UserUtil.initDoc(collection: "likes")
    }
    

}
