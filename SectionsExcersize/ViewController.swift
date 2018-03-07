//
//  ViewController.swift
//  SectionsExcersize
//
//  Created by Javier Perez Primary on 3/7/18.
//  Copyright © 2018 JavierPerez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let sectionTablesIdentifier = "SectionTablesIdentifier"
    var names: [String:[String]]!
    var keys: [String]!

    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionTablesIdentifier)
        
        let path = Bundle.main.path(forResource: "sortednames", ofType: "plist")
        
        let namesDict = NSDictionary(contentsOfFile: path!)
        
        names = namesDict as! [String: [String]]
        keys = (namesDict!.allKeys as! [String]).sorted()
        
        
        let resultsController = SearchResultsControllerTableViewController()
        resultsController.names =  names
        resultsController.keys = keys
        searchController = UISearchController(searchResultsController: resultsController)
        
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["All", "Short", "Long"]
        searchBar.placeholder = "Enter a search term"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
        
        
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int  {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let nameSection = names[key]!
        return nameSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return keys[section]
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionTablesIdentifier, for: indexPath)
        as UITableViewCell
        let key = keys[indexPath.section]
        let nameSection = names[key]!
            cell.textLabel?.text = nameSection[indexPath.row]
        
        return cell
    
    
    }
    
    func sectionIndexTitles(for tableView: UITableView) ->[String]? {
        return keys
    }
    
}

