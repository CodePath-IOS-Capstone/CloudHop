//
//  RecommendationListViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/2/22.
//

import UIKit

class RecommendationListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var recommendations = [String]()
    
    @IBOutlet weak var recommendTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recommend"

        // Do any additional setup after loading the view.
        
        recommendTable.delegate = self
        recommendTable.dataSource = self
        
        UserUtil.getRecommendations(email: UserUtil.userEmail) { rec in
            self.recommendations = Array(rec.keys).sorted(by: { rec[$0]! > rec[$1]! })
            self.recommendTable.reloadData()
        }
        
        self.recommendTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendTable.dequeueReusableCell(withIdentifier: "recommendAllCell") as! AllRecommendationsTableViewCell
        
        var sortedRecs = [String]()
        
            UserUtil.getRecommendations(email: UserUtil.userEmail) { rec in
                sortedRecs = Array(rec.keys).sorted(by: { rec[$0]! > rec[$1]! })
                sortedRecs.sort()
                
                let city = sortedRecs[indexPath.row]
                    

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
        
        
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "recommendedCellSegue" {
                let selectedIndexPath = recommendTable.indexPath(for: sender as! AllRecommendationsTableViewCell)!
                let destinationController = segue.destination as! LocationDetailedViewController
                let recs = recommendations.sorted()
                let carry = recs[selectedIndexPath.row]
                destinationController.place = carry
            }
    }
    

}
