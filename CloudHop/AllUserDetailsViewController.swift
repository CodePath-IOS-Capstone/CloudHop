//
//  AllUserDetailsViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/13/22.
//

import UIKit

class AllUserDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCountry: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var likeTable: UICollectionView!
    @IBOutlet weak var followerTable: UICollectionView!
    var emailUser = String()
    var likes = [String]()
    var followers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage?.layer.cornerRadius = (userImage?.frame.size.width ?? 0.0) / 2
        userImage?.clipsToBounds = true
        userImage?.layer.borderWidth = 3.0
        userImage?.layer.borderColor = UIColor.white.cgColor
        
        UserUtil.getUsername(email: emailUser) { username in
            self.userName.text = "@\(username)"
        }
        UserUtil.getUserCountry(email: emailUser) { country in
            self.userCountry.text = country
        }
        UserUtil.getFollowerCount(email: emailUser) { followerCount in
            self.followerCount.text = followerCount
        }
        UserUtil.getFollowingCount(email: emailUser) { followingCount in
            self.followingCount.text = followingCount
        }
        
        // Do any additional setup after loading the view.
        likeTable.delegate = self
        likeTable.dataSource = self
        followerTable.delegate = self
        followerTable.dataSource = self
        
        UserUtil.getLikedLocationsArray(email: emailUser) { like in
            self.likes = like
            self.likeTable.reloadData()
        }
        
        UserUtil.getFollowers(email: emailUser) { followers in
            print(">>>", followers)
            self.followers = followers
            self.followerTable.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.likeTable {
            return likes.count
        } else {
            return followers.count
        }
        
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.likeTable {
            let cell = likeTable.dequeueReusableCell(withReuseIdentifier: "UserLikesCell", for: indexPath) as! UserLikesCell
            
            
            let city = likes[indexPath.item]
                
            cell.cityName.text = city
                
            UserUtil.getImagePath(city: city) { img in
                let cityUrl = URL(string: img)
                cell.cityImage.af.setImage(withURL: cityUrl!)
            }
            return cell
        } else {
            let cell = followerTable.dequeueReusableCell(withReuseIdentifier: "FollowersCell", for: indexPath) as! FollowersCell
            
            
            let followerEmail = followers[indexPath.item]
                
            UserUtil.getUsername(email: followerEmail) { username in
                cell.followerName.text = "@\(username)"
            }
            
            return cell
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
