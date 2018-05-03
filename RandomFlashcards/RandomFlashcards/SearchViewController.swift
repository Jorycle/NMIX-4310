//
//  SearchViewController.swift
//  RandomFlashcards
//
//  Created by Jorycle on 5/1/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var SearchTable: UITableView!
    @IBOutlet weak var SearchText: UITextField!
    var flashData: DataController!
    var dataValues: NSArray = []
    var segueValues: NSArray = []
    var selectedSet: String? = nil
    var noDataLabel: UILabel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTable.dataSource = self
        SearchTable.delegate = self
        noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SearchTable.bounds.size.width, height: SearchTable.bounds.size.height))
        noDataLabel?.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        noDataLabel?.textAlignment = NSTextAlignment.center
        noDataLabel?.text = "Search for something!"
        self.SearchTable.backgroundView = noDataLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValues.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let valueMaker = dataValues[(indexPath as NSIndexPath).row]
        let resultName = (valueMaker as AnyObject)["title"] as? String
        let resultCount = (valueMaker as AnyObject)["term_count"] as? Int
        cell.ResultName.text = resultName
        cell.ResultCount.text = (resultCount.map(String.init) ?? "") + " terms"
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let valueMaker = dataValues[(indexPath as NSIndexPath).row]
        let setID = (valueMaker as AnyObject)["id"] as? Int!
        selectedSet = setID.map(String.init)!
    }
    
    @IBAction func SearchButton(_ sender: Any) {
        var textBoxData = SearchText.text
        textBoxData = textBoxData?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let dataUrl = NSURL(string: "https://api.quizlet.com/2.0/search/sets?client_id=jVUQAWaDYb&whitespace=1&q=" + textBoxData!)
        let theData = NSData(contentsOf: dataUrl! as URL)
        guard theData != nil else
        {
            return
        }
        let json = try! (JSONSerialization.jsonObject(with: theData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary)
        self.dataValues = json.value(forKey: "sets") as! NSArray
        if (self.dataValues.count == 0)
        {
            noDataLabel?.text = "No sets found!"
            self.SearchTable.backgroundView = noDataLabel
        }
        else
        {
            self.SearchTable.backgroundView = nil
            
        }
        SearchTable.reloadData()
    }
    
    @IBAction func SelectButton(_ sender: Any) {
        guard selectedSet != nil else
        {
            let failAlert = UIAlertController(title: "Failure", message: "No set selected!", preferredStyle: .alert)
            failAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(failAlert, animated: true, completion: nil)
            return
        }
        
        let dataUrl = NSURL(string: "https://api.quizlet.com/2.0/sets/" + selectedSet! + "/terms?client_id=jVUQAWaDYb&whitespace=1")
        let theData = NSData(contentsOf: dataUrl! as URL)
        self.segueValues = try! JSONSerialization.jsonObject(with: theData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        self.performSegue(withIdentifier: "AddSearch", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "CancelSearch")
        {
            let receiver = segue.destination as! HubViewController
            receiver.flashData = flashData
        }
        else if (segue.identifier == "AddSearch")
        {
            let receiver = segue.destination as! NewCardsViewController
            receiver.flashData = flashData
            receiver.dataValues = segueValues
        }
    }

}
