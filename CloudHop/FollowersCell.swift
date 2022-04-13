//
//  FollowersCell.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/13/22.
//

import UIKit

class FollowersCell: UICollectionViewCell {
    @IBOutlet weak var followerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Apply rounded corners
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
                
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 12.0
        layer.masksToBounds = false
    }
}
