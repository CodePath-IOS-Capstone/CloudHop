//
//  PreferenceCollectionViewCell.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/3/22.
//

import UIKit

class PreferenceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!

    @IBOutlet weak var likeButton: UIButton!
    
    var checked = false
    
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
            checked = false
        }
    }
}
