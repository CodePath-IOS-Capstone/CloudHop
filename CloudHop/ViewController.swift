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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        postDoc(collection: "users", data: ["name": "Carlos"])
//        getDoc(collection: "users", document: "Carlos")
    }

    func postDoc(collection: String, data: NSDictionary) {
        // TODO: replace docID with email once auth is set up
        
//        let collectionRef = db.collection(collection)
//        let docId = collectionRef.document().documentID
        let name = data["name"] as! String
        let documentRef = db.document("\(collection)/\(name)")
        documentRef.setData(["text": name])
        
    }
    
    func getDoc(collection: String, document: String) {
        let docRef = db.document("\(collection)/\(document)")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            print(data)
        }
    }

}

