//
//  UserAccountViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/8/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class UserAccountViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var userCountry: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var likeGrid: UICollectionView!
    @IBOutlet weak var followGrid: UICollectionView!
    
    var likes = [String]()
    var followers = [String]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage?.layer.cornerRadius = (userImage?.frame.size.width ?? 0.0) / 2
        userImage?.clipsToBounds = true
        userImage?.layer.borderWidth = 3.0
        userImage?.layer.borderColor = UIColor.white.cgColor

        UserUtil.getUsername(email: UserUtil.userEmail) { username in
            self.username.text = "@\(username)"
        }
        
        UserUtil.getFollowerCount(email: UserUtil.userEmail) { followerCount in
            self.followerCount.text = followerCount
        }
        
        UserUtil.getFollowingCount(email: UserUtil.userEmail) { followingCount in
            self.followingCount.text = followingCount
        }
        
        UserUtil.getUserCountry(email: UserUtil.userEmail) { country in
            self.userCountry.text = country
        }
        
        UserUtil.getProfilePicture(email: UserUtil.userEmail) { img in
            let pfpUrl = URL(string: img)!
            self.userImage.af.setImage(withURL: pfpUrl)
        }
        // Do any additional setup after loading the view.
        likeGrid.delegate = self
        likeGrid.dataSource = self
        followGrid.delegate = self
        followGrid.dataSource = self
        
        UserUtil.getLikedLocationsArray(email: UserUtil.userEmail) { like in
            self.likes = like
            self.likeGrid.reloadData()
        }
        
        UserUtil.getFollowers(email: UserUtil.userEmail) { followers in
            print(">>>", followers)
            self.followers = followers
            self.followGrid.reloadData()
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.likeGrid {
            return likes.count
        } else {
            print(followers)
            return followers.count
        }
        
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.likeGrid {
            let cell = likeGrid.dequeueReusableCell(withReuseIdentifier: "UserLikesCell", for: indexPath) as! UserLikesCell
            
            
            let city = likes[indexPath.item]
                
            cell.cityName.text = city
                
            UserUtil.getImagePath(city: city) { img in
                let cityUrl = URL(string: img)
                cell.cityImage.af.setImage(withURL: cityUrl!)
            }
            return cell
        } else {
            let cell = followGrid.dequeueReusableCell(withReuseIdentifier: "FollowersCell", for: indexPath) as! FollowersCell
            
            
            let followerEmail = followers[indexPath.item]
                
            UserUtil.getUsername(email: followerEmail) { username in
                cell.followerName.text = "@\(username)"
            }
            
            return cell
        }
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "logoutSegue" else { return }
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        
    }
    

}
