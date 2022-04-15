//
//  UserSearchViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/13/22.
//

import UIKit

class UserSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var allUsers = [String]()
    var filteredUsers = [String]()

    var filtered = false
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var userTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTable.delegate = self
        userTable.dataSource = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        
        UserUtil.getCollection(collection: "users") { col in
            self.allUsers = col
            self.userTable.reloadData()
        }
        
        userTable.reloadData()
        userTable.keyboardDismissMode = .onDrag
        searchBar.setSearchIcon(UIImage(named: "search1")!)
        searchBar.tintColor = UIColor.lightGray
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if string.count == 0 {
                filterText(query: String(text.dropLast()))
                        } else {
                            filterText(query: text + string)
                        }
        }
        
        
        return true
    }
    
    func filterText(query: String) {
        filteredUsers.removeAll()
        for string in allUsers {
            if string.lowercased().starts(with: query.lowercased()) {
                filteredUsers.append(string)
            }
        }
        userTable.reloadData()
        filtered = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredUsers.isEmpty {
            return filteredUsers.count
        }
        return filtered ? 0 : allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userTable.dequeueReusableCell(withIdentifier: "UserSearchCell") as! UserSearchCell
        
        
        if !filteredUsers.isEmpty {
            let user = filteredUsers[indexPath.row]
            
            cell.emailOfUser = user
            
            UserUtil.getFollowing(email: UserUtil.userEmail) { following in
                if following.contains(user) {
                    cell.checked = true
                    cell.followedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } else {
                    cell.checked = false
                    cell.followedButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
            
            UserUtil.getUsername(email: user) { username in
                cell.userName.text = "@\(username)"
            }
            UserUtil.getUserCountry(email: user) { country in
                cell.userCountry.text = country
            }
            UserUtil.getProfilePicture(email: user) { img in
                let pfpUrl = URL(string: img)!
                cell.userImage.af.setImage(withURL: pfpUrl)
            }
        } else {
            let user = allUsers[indexPath.row]
            
            cell.emailOfUser = user
            
            UserUtil.getFollowing(email: UserUtil.userEmail) { following in
                if following.contains(user) {
                    cell.checked = true
                    cell.followedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } else {
                    cell.checked = false
                    cell.followedButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
            
            UserUtil.getUsername(email: user) { username in
                cell.userName.text = "@\(username)"
            }
            UserUtil.getUserCountry(email: user) { country in
                cell.userCountry.text = country
            }
            UserUtil.getProfilePicture(email: user) { img in
                let pfpUrl = URL(string: img)!
                cell.userImage.af.setImage(withURL: pfpUrl)
            }
        }
        
        // TODO: user profile pictures
        
        return cell
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "userSearchDetail" else { return }
        if !filteredUsers.isEmpty {
            let selectedIndexPath = userTable.indexPath(for: sender as! UserSearchCell)!
            let destinationController = segue.destination as! AllUserDetailsViewController
            let carry = filteredUsers[selectedIndexPath.row]
            destinationController.emailUser = carry
        } else {
            let selectedIndexPath = userTable.indexPath(for: sender as! UserSearchCell)!
            let destinationController = segue.destination as! AllUserDetailsViewController
            let carry = allUsers[selectedIndexPath.row]
            destinationController.emailUser = carry
        }
        
    }
    

}
