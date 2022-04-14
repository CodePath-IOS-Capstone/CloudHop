//
//  PreferencesCell.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/2/22.
//

import UIKit

class PreferencesCell: UICollectionViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    
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
