//
//  ViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 3/18/22.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    let db = Firestore.firestore()
    
    let model = cityRecommender()
    var resultsBack: [String : Double] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var userLikes = ["Asuncion":10.0]
        userLikes["Porto Alegre"] = 10.0
        print("USERLIKES----------------")
        print(userLikes)
        
        let input = cityRecommenderInput(items: userLikes, k: 25)
        
        guard let unwrappedResults = try? model.prediction(input: input) else {
                        fatalError("Could not get results back!")
                    }
        let results = unwrappedResults.scores
                
        resultsBack = results
        print("RESULTS--------------------")
        print(results)

        
        // testing document gets and posts
        createNewUserDocument(data: ["name": "Carlos", "email": "test@gmail.com", "country": "USA"])
        addLikedLocation(location: "Miami", data: ["email": "test@gmail.com"])
//        getDoc(collection: "users", document: "Carlos")
        getLikedLocations(email: "test@gmail.com")
        
    }
    
    
    /*
    Basic function for posting a doc to a collection
    */
    func postDoc(collection: String, data: NSDictionary) {
        // TODO: replace docID with email once auth is set up
        
//        let collectionRef = db.collection(collection)
//        let docId = collectionRef.document().documentID
        let name = data["name"] as! String
        let documentRef = db.document("\(collection)/\(name)")
        documentRef.setData(["text": name])
        
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
    Update function to append a new location to the location collection. Stored under the document named after the user email.
    */
    func addLikedLocation(location: String, data: NSDictionary) {
        let email = data["email"] as! String
        
        let documentRef = db.document("locations/\(email)")
        
        documentRef.setData([location:10.0], merge: true)
        
    }
    
    /*
    Read function to get the values in the locations document. Takes user email and searches that document.
    */
    func getLikedLocations(email: String) {
        let locationsRef = db.document("locations/\(email)")
        
        locationsRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            print(data.keys)
        }
    }
    
    /*
    Basic function for getting a document from a collection
    */
    func getDoc(collection: String, document: String) {
        let docRef = db.document("\(collection)/\(document)")
        docRef.addSnapshotListener({ snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            print(data)
        })
    }

}

