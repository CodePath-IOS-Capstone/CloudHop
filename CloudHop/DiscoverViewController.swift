//
//  DiscoverViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/2/22.
//

import UIKit


extension UITextField {
func setSearchIcon(_ image: UIImage) {
   let iconView = UIImageView(frame:
                  CGRect(x: 320, y: 5, width: 20, height: 20))
   iconView.image = image
   let iconContainerView: UIView = UIView(frame:
                  CGRect(x: 0, y: 0, width: 0, height: 30))
   iconContainerView.addSubview(iconView)
   leftView = iconContainerView
   leftViewMode = .always
}
}
class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var discoverTable: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    var discover = [String]()
    var filteredDiscover = [String]()
    var filtered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Discover"
        // Do any additional setup after loading the view.
        discoverTable.delegate = self
        discoverTable.dataSource = self
        searchField.delegate = self
        
        UserUtil.getCollection(collection: "allCities") { col in
            self.discover = col
            self.discoverTable.reloadData()
        }
        
        discoverTable.keyboardDismissMode = .onDrag
        
        searchField.setSearchIcon(UIImage(named: "search1")!)
        searchField.tintColor = UIColor.lightGray
        
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
        filteredDiscover.removeAll()
        for string in discover {
            if string.lowercased().starts(with: query.lowercased()) {
                filteredDiscover.append(string)
            }
        }
        discoverTable.reloadData()
        filtered = true
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredDiscover.isEmpty {
            return filteredDiscover.count
        }
        return filtered ? 0 : discover.count
    }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = discoverTable.dequeueReusableCell(withIdentifier: "discoverAllCell") as! DiscoverTableViewCell
        
        if !filteredDiscover.isEmpty {
            let city = filteredDiscover[indexPath.row]
            
            UserUtil.getImagePath(city: city) { img in
                let cityUrl = URL(string: img)
                cell.cityImage.af.setImage(withURL: cityUrl!)
            }


            UserUtil.getDescription(city: city) { description in
                cell.desc.text = description
            }
            
            UserUtil.getCountry(city: city) { country in
                cell.cityName.text = "\(city), \(country)"
            }
            
            
        } else {
            UserUtil.getCollection(collection: "allCities") { col in
                let city = col[indexPath.row]
                

                UserUtil.getImagePath(city: city) { img in
                    let cityUrl = URL(string: img)
                    cell.cityImage.af.setImage(withURL: cityUrl!)
                }


                UserUtil.getDescription(city: city) { description in
                    cell.desc.text = description
                }
                
                UserUtil.getCountry(city: city) { country in
                    cell.cityName.text = "\(city), \(country)"
                }
            }
        }
        
        
        
        return cell
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
