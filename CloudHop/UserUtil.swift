//
//  UserUtil.swift
//  CloudHop
//
//  Created by Carlos Chavez on 3/29/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserUtil {
    static let db = Firestore.firestore()
    static var userEmail = ""
    static var userLikes = [String:Any]()
    
    static let model = cityRecommender()
    static var resultsBack = [String]()


    /*
    Read function to get the values in the locations document. Takes user email and searches that document.
    */
    static func getLikedLocations(email: String) {
        let locationsRef = db.document("locations/\(email)")
        
        locationsRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            self.userLikes = data
            print(self.userLikes)
        }
    }


    /*
    Function to get the current users email and save it in userEmail. Used when fetching information about the user from firestore.
    */
    static func getLoggedInUser() {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            userEmail = FirebaseAuth.Auth.auth().currentUser!.email!
        } else {
            print("Not signed in.")
        }
    }

    /*
    Function to compute recommendations from user liked locations document stored on firestore
    */

    static func predictModel(locations: Dictionary<String, Any>) {
        let input = cityRecommenderInput(items: locations as! [String : Double], k: 120)
        
        guard let unwrappedResults = try? model.prediction(input: input) else {
                        fatalError("Could not get results back!")
                    }
        let results = unwrappedResults.scores
        
        var sortedKeys = Array(results.keys).sorted(by: { results[$0]! < results[$1]! })
        
        resultsBack = sortedKeys
        print("RESULTS--------------------")
        print(results)
        print("RESULTS BACK--------------------")
        print(resultsBack)
        
    }
    
    /*
    Basic function for posting a doc to a collection
    */
    static func postDoc(collection: String, data: NSDictionary) {
        // TODO: replace docID with email once auth is set up
        
//        let collectionRef = db.collection(collection)
//        let docId = collectionRef.document().documentID
        let name = data["name"] as! String
        let documentRef = db.document("\(collection)/\(name)")
        documentRef.setData(["text": name])
        
    }
    
    /*
    Update function to append a new location to the location collection. Stored under the document named after the user email.
    */
    static func addLikedLocation(location: String, data: NSDictionary) {
        let email = data["email"] as! String
        
        let documentRef = db.document("locations/\(email)")
        
        documentRef.setData([location:10.0], merge: true)
        
    }
    
    /*
    Basic function for getting a document from a collection
    */
    static func getDoc(collection: String, document: String) {
        let docRef = db.document("\(collection)/\(document)")
        docRef.addSnapshotListener({ snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            print(data)
        })
    }
}

