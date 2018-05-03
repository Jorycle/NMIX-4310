//
//  NewCardsViewController.swift
//  MidtermProject
//
//  Created by Jorycle on 3/12/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit

class NewCardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dataValues: NSArray = []
    var flashData: DataController!
    var checkedArray: [Bool] = []
    var toggleState = false
    
    @IBOutlet weak var NewCardTable: UITableView!
    
    @IBAction func ToggleButton(_ sender: UIButton) {
        for i in 0..<checkedArray.count
        {
            checkedArray[i] = toggleState
        }
        NewCardTable.reloadData()
        toggleState = !toggleState
    }
    
    @IBAction func AddSButton(_ sender: UIButton) {
        let newValues: NSMutableArray = []
        for i in 0..<checkedArray.count
        {
            if (checkedArray[i] == true)
            {
                newValues.add(dataValues[i])
            }
        }
        dataValues = newValues
        performSegue(withIdentifier: "AddCards", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValues.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCells", for: indexPath) as! CardTableViewCell
        let valueMaker = dataValues[(indexPath as NSIndexPath).row]
        let cardTerm = (valueMaker as AnyObject)["term"] as? String
        let cardDef = (valueMaker as AnyObject)["definition"] as? String
        cell.termLabel.text = cardTerm
        cell.defLabel.text = cardDef
        cell.checkButton.isSelected = checkedArray[(indexPath as NSIndexPath).row]
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardTableViewCell
        checkedArray[indexPath.row] = !checkedArray[indexPath.row]
        cell.checkButton.isSelected = !cell.checkButton.isSelected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewCardTable.dataSource = self
        checkedArray = [Bool](repeating: true, count: dataValues.count)
        NewCardTable.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddCards")
        {
            let receiver = segue.destination as! HubViewController
            flashData.data.Rank1Words.addObjects(from: dataValues as! [Any])
            receiver.flashData = flashData
        }
        else if (segue.identifier == "CancelSegue")
        {
            let receiver = segue.destination as! HubViewController
            receiver.flashData = flashData
        }
    }

}
