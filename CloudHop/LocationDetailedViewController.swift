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
    @IBOutlet weak var descriptionBox: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var checkedB = Bool()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeButton.layer.shadowColor = UIColor.black.cgColor
        likeButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        likeButton.layer.shadowRadius = 3
        likeButton.layer.shadowOpacity = 0.5
        
    }
    
    @IBAction func likeOnClick(_ sender: Any) {
       
//        if !checkedB {
//            likeButton.setImage(UIImage(named: "heart.png"), for: .normal)
//            UserUtil.addLikedLocation(location: locationTitle.text!)
//            checkedB = true
//        } else {
//            likeButton.setImage(UIImage(named: "unfavorite.png"), for: .normal)
//            UserUtil.deleteLike(email: UserUtil.userEmail, field: locationTitle.text!)
//            checkedB = false
//        }
        
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
