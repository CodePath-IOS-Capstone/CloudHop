//
//  PreferencesViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/2/22.
//

import UIKit
import FirebaseFirestore

class PreferencesViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    var preferences = [String]()
    var startingPrefs = [String]()
    var likes = [String]()
    let db = Firestore.firestore()

    @IBOutlet weak var preferenceCollection: UICollectionView!
    @IBOutlet weak var sliderCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserUtil.getLoggedInUser() // maybe closure and do all bottom stuff there. Maybe set an initial like location too

        // Do any additional setup after loading the view.
        preferenceCollection.delegate = self
        preferenceCollection.dataSource = self
        sliderCollection.dataSource = self
        sliderCollection.delegate = self
        
        UserUtil.getCollection(collection: "startingPreferences") { col in
            self.startingPrefs = col
            self.sliderCollection.reloadData()
        }
        
        UserUtil.getLikedLocationsArray(email: UserUtil.userEmail) { like in
            
            self.preferences = like
            self.preferenceCollection.reloadData()
        }
    
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.preferenceCollection {
            return preferences.count
        } else {
            return startingPrefs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.preferenceCollection {
            
            let cell = preferenceCollection.dequeueReusableCell(withReuseIdentifier: "preferenceCell", for: indexPath) as! PreferencesCell

            let city = preferences[indexPath.item]
            cell.cityName.text = city


            return cell

        } else {
            let locationsRef = db.document("locations/\(UserUtil.userEmail)")
            
            let cell = self.sliderCollection.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! PreferenceCollectionViewCell
            
            locationsRef.addSnapshotListener { snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }

                
                let city = self.startingPrefs[indexPath.item]
                
                UserUtil.getCountry(city: city) { country in
                    cell.cityName.text = city
                    // TODO: COUNTRY NAME IN ITS OWN OUTLET
                }
                
                
                UserUtil.getImagePath(city: city) { img in
                    let imgUrl = URL(string: img)
                    cell.cityImage.af.setImage(withURL: imgUrl!)
                }
                
                if data.keys.contains(city) {
                    cell.likeButton.setImage(UIImage(named: "heart.png"), for: .normal)
                }
                
            }
            
            return cell
            
            
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.sliderCollection.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.sliderCollection.scrollToNearestVisibleCollectionViewCell()
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
