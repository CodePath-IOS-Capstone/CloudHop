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

    static var rndcity = ["Aarhus", "Adelaide", "Albuquerque", "Almaty", "Amsterdam", "Anchorage", "Andorra", "Ankara", "Asheville", "Asuncion", "Athens", "Atlanta", "Auckland", "Austin", "Baku", "Bali", "Baltimore", "Bangkok", "Barcelona", "Beijing", "Beirut", "Belfast", "Belgrade", "Belize City", "Bengaluru", "Bergen", "Berlin", "Bern", "Bilbao", "Birmingham", "Bogota", "Boise", "Bologna", "Bordeaux", "Boston", "Boulder", "Bozeman", "Bratislava", "Brighton", "Brisbane", "Bristol", "Brno", "Brussels", "Bucharest", "Budapest", "Buenos Aires", "Buffalo", "Cairo", "Calgary", "Cambridge", "Cape Town", "Caracas", "Cardiff", "Casablanca", "Charleston", "Charlotte", "Chattanooga", "Chennai", "Chiang Mai", "Chicago", "Chisinau", "Christchurch", "Cincinnati", "Cleveland", "Cluj-Napoca", "Cologne", "Colorado Springs", "Columbus", "Copenhagen", "Cork", "Curitiba", "Dallas", "Dar es Salaam", "Delhi", "Denver", "Des Moines", "Detroit", "Doha", "Dresden", "Dubai", "Dublin", "Dusseldorf", "Edinburgh", "Edmonton", "Eindhoven", "Eugene", "Florence", "Florianopolis", "Fort Collins", "Frankfurt", "Fukuoka", "Galway", "Gdansk", "Geneva", "Gibraltar", "Glasgow", "Gothenburg", "Grenoble", "Guadalajara", "Guatemala City", "Halifax", "Hamburg", "Hannover", "Havana", "Helsinki", "Ho Chi Minh City", "Hong Kong", "Honolulu", "Houston", "Hyderabad", "Indianapolis", "Innsbruck", "Istanbul", "Jacksonville", "Jakarta", "Johannesburg", "Kansas City", "Karlsruhe", "Kathmandu", "Kingston", "Knoxville", "Krakow", "Kuala Lumpur", "Kyiv", "Kyoto", "La Paz", "Lagos", "Las Palmas de Gran Canaria", "Las Vegas", "Lausanne", "Leeds", "Leipzig", "Lille", "Lima", "Lisbon", "Liverpool", "Ljubljana", "London", "Los Angeles", "Louisville", "Luxembourg", "Lviv", "Lyon", "Madison", "Madrid", "Malaga", "Malmo", "Managua", "Manchester", "Manila", "Marseille", "Medellin", "Melbourne", "Memphis", "Mexico City", "Miami", "Milan", "Milwaukee", "Minneapolis-Saint Paul", "Minsk", "Montevideo", "Montreal", "Moscow", "Mumbai", "Munich", "Nairobi", "Nantes", "Naples", "Nashville", "New Orleans", "New York", "Nice", "Nicosia", "Oklahoma City", "Omaha", "Orlando", "Osaka", "Oslo", "Ottawa", "Oulu", "Oxford", "Palo Alto", "Panama", "Paris", "Perth", "Philadelphia", "Phnom Penh", "Phoenix", "Phuket", "Pittsburgh", "Portland", "Porto", "Porto Alegre", "Prague", "Providence", "Quebec", "Quito", "Raleigh", "Reykjavik", "Richmond", "Riga", "Rio De Janeiro", "Riyadh", "Rochester", "Rome", "Rotterdam", "Saint Petersburg", "Salt Lake City", "San Antonio", "San Diego", "San Francisco Bay Area", "San Jose", "San Juan", "San Luis Obispo", "San Salvador", "Santiago", "Santo Domingo", "Sao Paulo", "Sarajevo", "Saskatoon", "Seattle", "Seoul", "Seville", "Shanghai", "Singapore", "Skopje", "Sofia", "St. Louis", "Stockholm", "Stuttgart", "Sydney", "Taipei", "Tallinn", "Tampa Bay Area", "Tampere", "Tartu", "Tashkent", "Tbilisi", "Tehran", "Tel Aviv", "The Hague", "Thessaloniki", "Tokyo", "Toronto", "Toulouse", "Tunis", "Turin", "Turku", "Uppsala", "Utrecht", "Valencia", "Valletta", "Vancouver", "Victoria", "Vienna", "Vilnius", "Warsaw", "Washington", "Wellington", "Winnipeg", "Wroclaw", "Yerevan", "Zagreb", "Zurich"]

    /*
    Read function to get the values in the locations document. Takes user email and searches that document.
    */
    static func getLikedLocations(email: String, completion: @escaping (_ like: [String:Double]) -> ()) {
        let locationsRef = db.document("likes/\(email)")
        
        locationsRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            print("email:", email)
            print("---->", data)
            let like = data as! [String:Double]
            completion(like)
            
        }
    }
    
    /*
    Read function to get the values in the locations document
    */
    static func getLikedLocations(email: String) {
        let locationsRef = db.document("likes/\(email)")
        
        locationsRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            self.userLikes = data
            
        }
    }

    /*
    Read function to get the values in the locations document. Takes user email and searches that document.
    */
    static func getLikedLocationsArray(email: String, completion: @escaping (_ like: [String]) -> ()) {
        let locationsRef = db.document("likes/\(email)")
        
        locationsRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            let like = data.keys
            completion(([String]) (like))
            
        }
    }
    
    /*
     Function to get the follower count of the user
    */
    
    static func getFollowerCount(email: String, completion: @escaping (_ followerCount: String) -> ()) {
        let followersRef = db.document("followers/\(email)")
        
        followersRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            let followers = data.keys
            let followerCount = followers.count
            completion((String) (followerCount))
            
        }
    }
    
    /*
     Function to get the following count of the user
    */
    
    static func getFollowingCount(email: String, completion: @escaping (_ followingCount: String) -> ()) {
        let followersRef = db.document("following/\(email)")
        
        followersRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            let following = data.keys
            let followingCount = following.count
            completion((String) (followingCount))
            
        }
    }
    
    /*
     Function to get the list of users following the logged in user
    */
    
    static func getFollowing(email: String, completion: @escaping (_ following: [String]) -> ()) {
        let followersRef = db.document("following/\(email)")
        
        followersRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            let following = data.keys
            completion(([String]) (following))
            
        }
    }
    
    /*
     Function to get the list of the users the logged in user follows
    */
    
    static func getFollowers(email: String, completion: @escaping (_ followers: [String]) -> ()) {
        let followersRef = db.document("followers/\(email)")
        
        followersRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            let followers = data.keys
            completion(([String]) (followers))
            
        }
    }
    
    /*
    Update function to follow a user
    */
    static func followUser(email: String, userToFollow: String) {
        
        let documentRef = db.document("following/\(userEmail)")
        
        documentRef.setData([userToFollow:1], merge: true)
        
    }
    
    /*
    Unfollow a user
    */
    
    static func unfollowUser(email: String, field: String) {
        db.collection("following").document(email).updateData([
            field : FieldValue.delete(),
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    /*
    Update function to set the user as followed
    */
    static func followingUser(email: String, userToFollow: String) {
        
        let documentRef = db.document("followers/\(userToFollow)")
        
        documentRef.setData([email:1], merge: true)
        
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
    Function to compute recommendations from user liked locations document stored on firestore <
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
    Function to compute recommendations from user liked locations document stored on firestore. Completion >
    */

    static func predictModel(locations: Dictionary<String, Double>, completion: @escaping (_ recs: [String:Double]) -> ()) {
        let input = cityRecommenderInput(items: locations, k: 120)
        
        guard let unwrappedResults = try? model.prediction(input: input) else {
                        fatalError("Could not get results back!")
                    }
        let results = unwrappedResults.scores
        
//        let sortedKeys = Array(results.keys).sorted(by: { results[$0]! > results[$1]! })
        
//        let recs = sortedKeys
        let recs = results
        print("RESULTS--------------------")
        print(results)
        print("RESULTS BACK--------------------")
        print(recs)
        
        
        completion(recs)
        
        
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
    Basic function for initializing an empty doc to a collection
    */
    static func initDoc(collection: String) {
        // TODO: replace docID with email once auth is set up
        
//        let collectionRef = db.collection(collection)
//        let docId = collectionRef.document().documentID
        
        let documentRef = db.document("\(collection)/\(UserUtil.userEmail)")
        documentRef.setData([String:Any]())
        
    }
    
    /*
    Update function to append a new location to the location collection. Stored under the document named after the user email.
    */
    static func addLikedLocation(location: String) {
        
        let documentRef = db.document("likes/\(userEmail)")
        
        documentRef.setData([location:10.0], merge: true)
        
    }
    
    /*
    Delete a liked location
    */
    
    static func deleteLike(email: String, field: String) {
        db.collection("likes").document(email).updateData([
            field : FieldValue.delete(),
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    /*
    Update function to append a recommendations to the recommendation collection. Stored under the document named after the user email.
    */
    static func postRecommendations(recommendations: [String:Any]) {
        
        let documentRef = db.document("recommendations/\(userEmail)")
        
        documentRef.setData(recommendations)
        
    }
    
    /*
    Read function to get the values in the recommendations document. Takes user email and searches that document.
    */
    static func getRecommendations(email: String, completion: @escaping (_ rec: [String:Double]) -> ()) {
        let locationsRef = db.document("recommendations/\(email)")
        
        locationsRef.addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            
            let filter = data as! [String:Double]
            var sum = 0.0
            for item in filter {
                sum += item.value
            }
            var average = sum / (Double) (filter.keys.count)
            average = average / 2.0
            print("Average-->>", average)
            
            var rec = [String:Double]()
            
            for item in filter {
                if item.value >= average {
                    rec[item.key] = item.value
                }
            }
            
            completion(rec)
            
        }
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
    
    static func getCollection(collection: String, completion: @escaping (_ col: [String]) -> ()) {
        db.collection("\(collection)").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var col = [String]()
                for document in querySnapshot!.documents {
                    
                    col.append(document.documentID)
                }
                print(col)
                completion(([String]) (col))
            }
        }
    }
    
    /*
    Basic function to get a city image URL
    */

    static func getImagePath(city: String, completion: @escaping (_ img: String) -> ()) {
        let docRef = db.collection("allCities").document("\(city)")

        docRef.addSnapshotListener({ snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            let img = data["image"] as? String ?? ""
            
            completion((String) (img))
            
        })
    }
    
    /*
    Basic function to get a city description
    */
    static func getDescription(city: String, completion: @escaping (_ desc: String) -> ()) {
        let docRef = db.collection("allCities").document("\(city)")

        docRef.addSnapshotListener({ snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            let description = data["descriptions"] as? String ?? ""
            
            completion((String) (description))
            
        })
    }
    
    /*
    Basic function to get a country for the city
    */
    static func getCountry(city: String, completion: @escaping (_ country: String) -> ()) {
        let docRef = db.collection("allCities").document("\(city)")

        docRef.addSnapshotListener({ snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            let country = data["country"] as? String ?? ""
            
            completion((String) (country))
            
        })
    }
    
    /*
    Basic function to get a country for the user
    */
    static func getUserCountry(email: String, completion: @escaping (_ country: String) -> ()) {
        let docRef = db.collection("users").document("\(email)")

        docRef.addSnapshotListener({ snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            let country = data["country"] as? String ?? ""
            
            completion((String) (country))
            
        })
    }
    
    /*
    Basic function to get a username from a userEmail
    */
    static func getUsername(email: String, completion: @escaping (_ username: String) -> ()) {
        let docRef = db.collection("users").document("\(email)")

        docRef.addSnapshotListener({ snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            let username = data["name"] as? String ?? ""
            
            completion((String) (username))
            
        })
    }
    
    static func setRandomPicture(email: String) {
        getImagePath(city: rndcity.randomElement()!) { img in
            let documentRef = db.document("users/\(email)")
            documentRef.setData(["profilePicture": img], merge: true)
        }
    }
    
    /*
    Basic function to get a city profile image URL
    */

    static func getProfilePicture(email: String, completion: @escaping (_ img: String) -> ()) {
        let docRef = db.collection("users").document("\(email)")

        docRef.addSnapshotListener({ snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            let img = data["profilePicture"] as? String ?? ""
            
            completion((String) (img))
            
        })
    }
}

