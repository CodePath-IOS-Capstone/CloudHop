//
//  RecommendCell.swift
//  CloudHop
//
//  Created by Carlos Chavez on 3/30/22.
//

import UIKit

class RecommendCell: UICollectionViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            cityImage?.layer.cornerRadius = 20
    }
    
    
}
