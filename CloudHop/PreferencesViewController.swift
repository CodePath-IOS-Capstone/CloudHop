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
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var preferenceCollection: UICollectionView!
    @IBOutlet weak var sliderCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserUtil.userEmail) // TESTING

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
    
        print("--->>>>>", preferences)
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
            let cell = self.sliderCollection.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! PreferenceCollectionViewCell
            
            let city = startingPrefs[indexPath.item]
            
            if preferences.contains(city) {
                cell.checked = true
                cell.likeButton.setImage(UIImage(named: "heart.png"), for: .normal)
            } else {
                cell.checked = false
                cell.likeButton.setImage(UIImage(named: "unfavorite.png"), for: .normal)
            }
 
            UserUtil.getCountry(city: city) { country in
                cell.cityName.text = city
                cell.countryName.text = country
            }
            
            
            UserUtil.getImagePath(city: city) { img in
                let imgUrl = URL(string: img)
                cell.cityImage.af.setImage(withURL: imgUrl!)
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
    
    func showAlert(title: String, description: String) {
        // Create new Alert
         var dialogMessage = UIAlertController(title: "\(title)", message: "\(description)", preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)
         // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toHome" {
            if preferences.count < 2 {
                showAlert(title: "Preferences", description: "Please like at least two locations to get more accurate recommendations.")
                return false
            } else {
                print("successful segue")
            }
        }
        return true
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
