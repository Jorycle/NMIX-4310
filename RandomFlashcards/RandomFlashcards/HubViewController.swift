//
//  HubViewController.swift
//  MidtermProject
//
//  Created by Jorycle on 3/10/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit

class HubViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var HubCollection: UICollectionView!
    var flashData: DataController!
    var cardList: NSMutableArray = []
    var dataValues: NSArray = []
    var rank1Ceiling = 0
    var rank2Ceiling = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hubCollectionCell", for: indexPath) as! HubCollectionViewCell
        
        let valueMaker = cardList[(indexPath as NSIndexPath).row]
        let cardTerm = (valueMaker as AnyObject)["term"] as? String
        
        cell.CellLabel.text = cardTerm
        
        if (indexPath.row >= rank2Ceiling)
        {
            cell.starImage.image = #imageLiteral(resourceName: "threestar")
        }
        else if (indexPath.row >= rank1Ceiling)
        {
            cell.starImage.image = #imageLiteral(resourceName: "twostar")
        }
        else
        {
            cell.starImage.image = #imageLiteral(resourceName: "onestar")
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HubCollection.dataSource = self
        cardList.addObjects(from: flashData.data.Rank1Words as! [Any])
        cardList.addObjects(from: flashData.data.Rank2Words as! [Any])
        cardList.addObjects(from: flashData.data.Rank3Words as! [Any])
        rank1Ceiling = flashData.data.Rank1Words.count
        rank2Ceiling = rank1Ceiling + flashData.data.Rank2Words.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func AddButton(_ sender: UIButton) {
        let alertController = UIAlertController.init(title: "Add New cards", message: "Add new cards by set ID, or search for the set you'd like to add!", preferredStyle: .actionSheet)
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let setSearch = UIAlertAction.init(title: "Search for Set...", style: .default, handler: { action in
            self.performSegue(withIdentifier: "Search", sender: self)
        })
        let setIDAdd = UIAlertAction.init(title: "Add By Set ID", style: .default, handler: { action in
            self.AddSetByID()
        })
        alertController.addAction(cancel)
        alertController.addAction(setIDAdd)
        alertController.addAction(setSearch)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func AddSetByID()
    {
        let alertControllerSet = UIAlertController(title: "Card Set Addition", message: "Enter Quizlet Set ID (the number in the URL of a set)", preferredStyle: .alert)
        
        // confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            let setID = alertControllerSet.textFields?[0].text
            
            let dataUrl = NSURL(string: "https://api.quizlet.com/2.0/sets/" + setID! + "/terms?client_id=jVUQAWaDYb&whitespace=1")
            let theData = NSData(contentsOf: dataUrl! as URL)
            
            guard theData != nil else
            {
                let failAlert = UIAlertController(title: "Failure", message: "Invalid set!", preferredStyle: .alert)
                failAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                self.present(failAlert, animated: true, completion: nil)
                return
            }
            self.dataValues = try! JSONSerialization.jsonObject(with: theData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            
            self.performSegue(withIdentifier: "AddSegue", sender: self)
        }
        
        // cancel action does nothing
        let cancelSetAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        // adding textfield to our dialog box
        alertControllerSet.addTextField { (textField) in
            textField.placeholder = "Set ID #"
        }
        
        // adding the actions to dialogbox
        alertControllerSet.addAction(confirmAction)
        alertControllerSet.addAction(cancelSetAction)
        
        // present the dialog box
        self.present(alertControllerSet, animated: true, completion: nil)
    }
    
    @IBAction func ShuffleButton(_ sender: Any) {
        if (cardList.count == 0)
        {
            let failAlert = UIAlertController(title: "No Cards", message: "Add some cards to shuffle!", preferredStyle: .alert)
            failAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(failAlert, animated: true, completion: nil)
        }
        else
        {
            self.performSegue(withIdentifier: "DisplayCard", sender: self)
        }
    }
    
    @IBAction func ClearButton(_ sender: Any) {
        if (cardList.count > 0)
        {
            let alertControllerRemoval = UIAlertController(title: "Clear Cards", message: "Are you sure you want to clear all cards?", preferredStyle: .alert)
            
            // confirm action taking the inputs
            let confirmRemoval = UIAlertAction(title: "Yes", style: .default) { (_) in
                    let newDataValues: NSArray = []
                    self.cardList.removeAllObjects()
                    self.dataValues = newDataValues
                    self.flashData.data.Rank1Words.removeAllObjects()
                    self.flashData.data.Rank2Words.removeAllObjects()
                    self.flashData.data.Rank3Words.removeAllObjects()
                    self.HubCollection.reloadData()
                }
            
            // cancel action does nothing
            let cancelRemoval = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
            // adding the actions to dialogbox
            alertControllerRemoval.addAction(confirmRemoval)
            alertControllerRemoval.addAction(cancelRemoval)
            
            // present the dialog box
            self.present(alertControllerRemoval, animated: true, completion: nil)
        }
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        flashData.saver()
        let SaveAlert = UIAlertController(title: "Set Saved", message: "Your current set has been saved!", preferredStyle: .alert)
        SaveAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(SaveAlert, animated: true, completion: nil)
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddSegue")
        {
            let receiver = segue.destination as! NewCardsViewController
            receiver.flashData = flashData
            receiver.dataValues = self.dataValues
        }
        else if (segue.identifier == "DisplayCard")
        {
            let receiver = segue.destination as! DisplayCardViewController
            receiver.flashData = flashData
        }
        else if (segue.identifier == "Search")
        {
         let receiver = segue.destination as! SearchViewController
            receiver.flashData = flashData
        }
    }

}
