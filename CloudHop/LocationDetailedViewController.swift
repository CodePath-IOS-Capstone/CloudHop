//
//  LocationDetailedViewController.swift
//  CloudHop
//
//  Created by Eva Sennrich on 4/8/22.
//

import UIKit

class LocationDetailedViewController: UIViewController {
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var countryTitle: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var descriptionBox: UITextView!
    
    
    var place = String()
    
    var checkedB = Bool()
    
    override func viewWillAppear(_ animated: Bool) {
        likeButton.layer.shadowColor = UIColor.black.cgColor
        likeButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        likeButton.layer.shadowRadius = 3
        likeButton.layer.shadowOpacity = 0.5
    }
    
    override func viewDidLoad() {
        
        locationTitle.text = place
        
        UserUtil.getImagePath(city: place) { img in
            let cityUrl = URL(string: img)
            self.locationImage.af.setImage(withURL: cityUrl!)
        }
        
        UserUtil.getDescription(city: place) { description in
            self.descriptionBox.text = description
        }
        
        UserUtil.getCountry(city: place) { country in
            self.countryTitle.text = country
        }
        
        UserUtil.getLikedLocationsArray(email: UserUtil.userEmail) { like in
            if like.contains(self.place) {
                self.checkedB = true
                self.likeButton.setImage(UIImage(named: "heart.png"), for: .normal)
            } else {
                self.checkedB = false
                self.likeButton.setImage(UIImage(named: "unfavorite.png"), for: .normal)
            }
        }
        
        
        
    }

    
    @IBAction func onLikeClick(_ sender: Any) {
        if !checkedB {
            likeButton.setImage(UIImage(named: "heart.png"), for: .normal)
            UserUtil.addLikedLocation(location: locationTitle.text!)
            checkedB = true
        } else {
            likeButton.setImage(UIImage(named: "unfavorite.png"), for: .normal)
            UserUtil.deleteLike(email: UserUtil.userEmail, field: locationTitle.text!)
            checkedB = false
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
