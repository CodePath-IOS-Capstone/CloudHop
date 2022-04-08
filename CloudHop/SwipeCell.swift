//
//  SwipeCell.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/7/22.
//

import UIKit

class SwipeCell: UICollectionViewCell {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityCountry: UILabel!
    @IBOutlet weak var cityDesc: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    var checked = Bool()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeButton.layer.shadowColor = UIColor.black.cgColor
        likeButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        likeButton.layer.shadowRadius = 3
        likeButton.layer.shadowOpacity = 0.5
        
    }
    
    @IBAction func onLike(_ sender: Any) {
        if !checked {
            likeButton.setImage(UIImage(named: "heart.png"), for: .normal)
            UserUtil.addLikedLocation(location: cityName.text!)
            checked = true
        } else {
            likeButton.setImage(UIImage(named: "unfavorite.png"), for: .normal)
            UserUtil.deleteLike(email: UserUtil.userEmail, field: cityName.text!)
            checked = false
        }
    }
    
    
    
}
