//
//  SearchResultsControllerTableViewController.swift
//  SectionsExcersize
//
//  Created by Javier Perez Primary on 3/7/18.
//  Copyright © 2018 JavierPerez. All rights reserved.
//

import UIKit

class SearchResultsControllerTableViewController: UITableViewController, UISearchResultsUpdating {
    
    private static let longNameSize = 6
    private static let shortNamesButtonIndex = 1
    private static let longNamesButtonIndex = 2
    
    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names:[String:[String]] = [String: [String]]()
    var keys: [String] = []
    var filteredNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    // This is the proper way to do this for such a thing for this
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionsTableIdentifier)
        cell!.textLabel?.text = filteredNames[indexPath.row]
        return cell!
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
            filteredNames.removeAll(keepingCapacity: true)
            
            if !searchString.isEmpty {
                let filter: (String) -> Bool = { name in
                    // Filter out long or short names depending on which
                    // scope button is selected.
                    let nameLength = name.characters.count
                    if (buttonIndex == SearchResultsControllerTableViewController.shortNamesButtonIndex
                        && nameLength >= SearchResultsControllerTableViewController.longNameSize)
                        || (buttonIndex == SearchResultsControllerTableViewController.longNamesButtonIndex
                            && nameLength < SearchResultsControllerTableViewController.longNameSize) {
                        return false
                    }
                    
                    let range = name.range(of: searchString, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                    return range != nil
                }
                
                for key in keys {
                    let namesForKey = names[key]!
                    let matches = namesForKey.filter(filter)
                    filteredNames += matches
                }
            }
        }
        tableView.reloadData()
    }


}
