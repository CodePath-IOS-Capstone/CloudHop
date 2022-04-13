//
//  UserSearchCell.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/13/22.
//

import UIKit

class UserSearchCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCountry: UILabel!
    @IBOutlet weak var followedButton: UIButton!
    
    var emailOfUser = ""
    var checked = Bool()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage?.layer.cornerRadius = (userImage?.frame.size.width ?? 0.0) / 2
        userImage?.clipsToBounds = true
        userImage?.layer.borderWidth = 3.0
        userImage?.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onFollow(_ sender: Any) {
        if !checked {
            UserUtil.followUser(email: UserUtil.userEmail, userToFollow: emailOfUser)
            UserUtil.followingUser(email: UserUtil.userEmail, userToFollow: emailOfUser)
            followedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            checked = true
        } else {
            UserUtil.unfollowUser(email: UserUtil.userEmail, field: emailOfUser)
            followedButton.setImage(UIImage(systemName: "heart.circle"), for: .normal)
            checked = false
        }
    }
    
}
