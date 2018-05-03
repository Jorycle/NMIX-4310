//
//  LoadCardsViewController.swift
//  MidtermProject
//
//  Created by Joseph Clements on 3/8/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit

class LoadCardsViewController: UITableViewController {
    
    var dataValues: NSArray = []
    var tempArray: NSMutableArray = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiver = segue.destination as! HubViewController
        tempArray.addObjects(from: dataValues as! [Any])
        receiver.cardList = tempArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataValues.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let cellHeight: CGFloat = 10
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView
    {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCells", for: indexPath) as! CardTableViewCell
        let valueMaker = dataValues[(indexPath as NSIndexPath).section]
        let cardTerm = (valueMaker as AnyObject)["term"] as? String
        let cardDef = (valueMaker as AnyObject)["definition"] as? String
        cell.termLabel.text = cardTerm
        cell.defLabel.text = cardDef
        cell.backgroundColor = UIColor.clear

        return cell
    }


}
