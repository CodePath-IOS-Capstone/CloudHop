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
        title = "Recommendations"

        // Do any additional setup after loading the view.
        
        recommendTable.delegate = self
        recommendTable.dataSource = self
        
        recommendations = UserUtil.resultsBack
        
        self.recommendTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendTable.dequeueReusableCell(withIdentifier: "recommendAllCell") as! AllRecommendationsTableViewCell
        
        
        
        let city = recommendations[indexPath.row]
            

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
