//
//  HomeScreenViewController.swift
//  CloudHop
//
//  Created by Eva Sennrich on 3/25/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import AlamofireImage

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    var locations = [String]()
    
    
    @IBOutlet weak var recommendGrid: UICollectionView!
    @IBOutlet weak var locationsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        UserUtil.getLoggedInUser()        
        
        
        recommendGrid.delegate = self
        recommendGrid.dataSource = self
        
        locationsTable.delegate = self
        locationsTable.dataSource = self
        
        UserUtil.getLikedLocations(email: UserUtil.userEmail) { like in
            UserUtil.predictModel(locations: like) { recs in
                var hits = [String:Double]()
                for rec in  recs {
                    if rec.value > 0 {
                        hits[rec.key] = rec.value
                    }
                }
                UserUtil.postRecommendations(recommendations: hits)
            }
        }
        
        self.recommendGrid.reloadData()
        
        UserUtil.getCollection(collection: "allCities") { col in
            self.locations = col
            self.locationsTable.reloadData()
        }
        
        self.locationsTable.reloadData()
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendGrid.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as! RecommendCell
        
        var sortedRecs = [String]()
        
            UserUtil.getRecommendations(email: UserUtil.userEmail) { rec in
                sortedRecs = Array(rec.keys).sorted(by: { rec[$0]! > rec[$1]! })
                sortedRecs.sort()
                let city = sortedRecs[indexPath.item]
                let name = city
            

                UserUtil.getImagePath(city: city) { img in
                    let cityUrl = URL(string: img)
                    cell.cityImage.af.setImage(withURL: cityUrl!)
                }
                
                cell.cityName.text = name
            }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationsTable.dequeueReusableCell(withIdentifier: "LocationsHomeCell") as! LocationHomeCell
        
        
        UserUtil.getCollection(collection: "allCities") { col in
            let city = col[indexPath.row]
            

            UserUtil.getImagePath(city: city) { img in
                let cityUrl = URL(string: img)
                cell.cityImage.af.setImage(withURL: cityUrl!)
            }


            UserUtil.getDescription(city: city) { description in
                cell.cityDesc.text = description
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

        
        if segue.identifier == "discoverHomeCellSegue" {
                let selectedIndexPath = locationsTable.indexPath(for: sender as! LocationHomeCell)!
                let destinationController = segue.destination as! LocationDetailedViewController
                let carry = locations[selectedIndexPath.row]
                destinationController.place = carry
            }
        
    }

}
