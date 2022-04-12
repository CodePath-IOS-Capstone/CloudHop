//
//  SwipeViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/7/22.
//

import UIKit
import FirebaseFirestore

class SwipeViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate  {

    var preferences = [String]()
    var likes = [String]()
    var allLocations = [String]()
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var swipeCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserUtil.userEmail) // TESTING

        // Do any additional setup after loading the view.
        swipeCollection.dataSource = self
        swipeCollection.delegate = self
        
        UserUtil.getLikedLocationsArray(email: UserUtil.userEmail) { like in
            
            self.preferences = like
//            self.swipeCollection.reloadData()
        }
        
        UserUtil.getCollection(collection: "allCities") { col in
           
            self.allLocations = col.shuffled()
            self.swipeCollection.reloadData()
            
            
        
        }
    
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLocations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.swipeCollection.dequeueReusableCell(withReuseIdentifier: "swipeCell", for: indexPath) as! SwipeCell
        
        let city = allLocations[indexPath.item]
        
        if preferences.contains(city) {
            cell.checked = true
            cell.likeButton.setImage(UIImage(named: "heart.png"), for: .normal)
        } else {
            cell.checked = false
            cell.likeButton.setImage(UIImage(named: "unfavorite.png"), for: .normal)
        }
    
        cell.cityName.text = city
        
        UserUtil.getCountry(city: city) { country in
            cell.cityCountry.text = country
        }
        
        UserUtil.getImagePath(city: city) { img in
            let imgUrl = URL(string: img)
            cell.cityImage.af.setImage(withURL: imgUrl!)
        }
        
        UserUtil.getDescription(city: city) { desc in
            cell.cityDesc.text = desc
        }

        return cell
            
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.swipeCollection.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.swipeCollection.scrollToNearestVisibleCollectionViewCell()
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
