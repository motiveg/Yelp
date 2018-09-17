//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    var searchBar = UISearchBar()
    //var filteredBusinesses: [Business]!
    //var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        navigationItem.titleView = searchBar
        
//        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
//
//                self.businesses = businesses
//                self.tableView.reloadData()
//                if let businesses = businesses {
//                    for business in businesses {
//                        print(business.name!)
//                        print(business.address!)
//                    }
//                }
//
//            }
//        )
        
        if (searchBar.text == "") {
            businessSearch("Food")
        }
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm(term: "Restaurants", sort: .distance, categories: ["asianfusion", "burgers"]) { (businesses, error) in
                self.businesses = businesses
                 for business in self.businesses {
                     print(business.name!)
                     print(business.address!)
                 }
         }
         */
        
    }
    
    func businessSearch(_ searchTerm: String) {
        Business.searchWithTerm(term: searchTerm, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
        }
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (businesses != nil) {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell

        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
//        businessSearch(_ searchTerm: String)
        
        if (searchBar.text != "") {
            if (businesses != nil) {
                businesses.removeAll()
            }
            //searching = true
            businessSearch(searchBar.text!)
            
        }
        //else {
            //searching = false
        //}
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        //searching = false
        businesses.removeAll()
        view.endEditing(true)
        self.tableView.reloadData()
    }
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        searchBar.endEditing(true)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    // Credit:
    // code below edited from
    // https://stackoverflow.com/questions/32025960/search-bar-cancel-button-in-navigation-bar
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // closes the keyboard
        searchBar.resignFirstResponder()
        
        // If you are using a search controller
        // self.searchDisplayControllerCustom.setActive(false, animated: true)
        
        // remove the cancel button
        self.navigationItem.setRightBarButton(nil, animated: true)
    }
    
    func cancelBarButtonItemClicked() {
        self.searchBarCancelButtonClicked(self.searchBar)
    }
    
}
