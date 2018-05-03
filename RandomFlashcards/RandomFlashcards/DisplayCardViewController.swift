//
//  DisplayCardViewController.swift
//  MidtermProject
//
//  Created by Jorycle on 3/10/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit
import GameplayKit

class DisplayCardViewController: UIViewController {
    
    @IBOutlet weak var RemoveHelp: UIButton!
    @IBOutlet weak var HelpOverlay: UIView!
    @IBOutlet weak var HelpButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var ViewBack: UIView!
    @IBOutlet weak var cardText: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardStateLabel: UILabel!
    @IBOutlet weak var OneStarButton: UIButton!
    @IBOutlet weak var TwoStarButton: UIButton!
    @IBOutlet weak var ThreeStarButton: UIButton!
    var futureDeck: NSMutableArray = []
    var currCardNum = 0
    var currDeck: NSMutableArray = []
    var probabilityArray: NSMutableArray = []
    var flashData: DataController!
    var prevStack: [(deck: NSMutableArray, card: Int, ident: NSDictionary)] = []
    var ratingChange = false
    var state = "term"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        create_probabilities()
        ViewBack.layer.cornerRadius = 9
        ViewBack.layer.masksToBounds = true
        cardStateLabel.text = state.uppercased()
        randomizeCard()
    }
    
    func create_probabilities()
    {
        probabilityArray.removeAllObjects()
        var rank1Nums = 0
        var rank2Nums = 0
        var rank3Nums = 0
        let r1count = flashData.data.Rank1Words.count
        let r2count = flashData.data.Rank2Words.count
        let r3count = flashData.data.Rank3Words.count
       
        if (r1count > 0)
        {
            rank1Nums += 6
            if (r3count == 0) {
                rank1Nums += 1 }
            if (r2count == 0) {
                rank1Nums += 3 }
        }
        if (r2count > 0)
        {
            rank2Nums += 3
            if (r3count == 0 && r1count == 0) {
                rank2Nums += 7 }
            else if (r1count == 0) {
                rank2Nums += 6 }
        }
        if (r3count > 0)
        {
            rank3Nums += 1
            if (r1count == 0 && r2count == 0) {
                rank3Nums += 9 }
        }
        
        for _ in 0..<rank1Nums
        {
            probabilityArray.add(flashData.data.Rank1Words)
        }
        for _ in 0..<rank2Nums
        {
            probabilityArray.add(flashData.data.Rank2Words)
        }
        for _ in 0..<rank3Nums
        {
            probabilityArray.add(flashData.data.Rank3Words)
        }
    }
    
    @IBAction func nextCard(_ sender: Any) {
        var prevDeck: NSMutableArray
        var prevCardNum: Int
        let prevIdent = currDeck[currCardNum] as! NSDictionary
        
        // Remove card from prevStack if already present
        for (index, element) in prevStack.enumerated()
        {
            if (element.ident == prevIdent)
            {
                prevStack.remove(at: index)
            }
        }
        
        // Rating change means we update the decks and probabilities
        if (ratingChange)
        {
            currDeck.removeObject(at: currCardNum)
            futureDeck.add(prevIdent)
            prevDeck = futureDeck
            prevCardNum = futureDeck.count - 1
            
            // If it's in the previous stack, update it
            for var x in prevStack
            {
                if (x.ident == prevIdent)
                {
                    x.card = prevCardNum
                    x.deck = prevDeck
                }
            }
            create_probabilities()
        }
        else
        {
            prevDeck = currDeck
            prevCardNum = currCardNum
        }
        prevStack.append((prevDeck, prevCardNum, prevIdent))
        
        // Only maintain 10 items in the prev stack
        if (prevStack.count > 10)
        {
            prevStack.removeFirst()
        }
        
        randomizeCard()
    }
    
    @IBAction func remove_help(_ sender: Any) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            self.HelpOverlay.alpha = 0.0
        }, completion: nil)
        HelpOverlay.isHidden = true
        RemoveHelp.isHidden = true
    }
    
    
    @IBAction func prevCard(_ sender: Any) {
        if (prevStack.count > 0)
        {
            currDeck = prevStack[prevStack.count-1].deck
            currCardNum = prevStack[prevStack.count-1].card
            prevStack.removeLast()
            getCardData()
            preset_rating()
        }
    }
    
    @IBAction func oneStarPress(_ sender: Any) {
        animateButton(button: self.OneStarButton, expand: true)
        TwoStarButton.setImage(#imageLiteral(resourceName: "empty-star"), for: .normal)
        ThreeStarButton.setImage(#imageLiteral(resourceName: "empty-star"), for: .normal)
        animateButton(button: self.OneStarButton, expand: false)
        ratingChange = (currDeck != flashData.data.Rank1Words)
        futureDeck = flashData.data.Rank1Words
    }
    
    @IBAction func twoStarPress(_ sender: Any) {
        animateButton(button: self.OneStarButton, expand: true)
        animateButton(button: self.TwoStarButton, expand: true)
        TwoStarButton.setImage(#imageLiteral(resourceName: "filled-star"), for: .normal)
        ThreeStarButton.setImage(#imageLiteral(resourceName: "empty-star"), for: .normal)
        animateButton(button: self.OneStarButton, expand: false)
        animateButton(button: self.TwoStarButton, expand: false)
        ratingChange = (currDeck != flashData.data.Rank2Words)
        futureDeck = flashData.data.Rank2Words
    }
    
    @IBAction func threeStarPress(_ sender: Any) {
        animateButton(button: self.OneStarButton, expand: true)
        animateButton(button: self.TwoStarButton, expand: true)
        animateButton(button: self.ThreeStarButton, expand: true)
        TwoStarButton.setImage(#imageLiteral(resourceName: "filled-star"), for: .normal)
        ThreeStarButton.setImage(#imageLiteral(resourceName: "filled-star"), for: .normal)
        animateButton(button: self.OneStarButton, expand: false)
        animateButton(button: self.TwoStarButton, expand: false)
        animateButton(button: self.ThreeStarButton, expand: false)
        ratingChange = (currDeck != flashData.data.Rank3Words)
        futureDeck = flashData.data.Rank3Words
    }

    
    @IBAction func press_help(_ sender: Any) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            self.HelpOverlay.alpha = 0.7
        }, completion: nil)
        HelpOverlay.isHidden = false
        RemoveHelp.isHidden = false
    }
    
    @IBAction func flipCard(_ sender: Any) {
        if (state == "term")
        {
            state = "definition"
        }
        else
        {
            state = "term"
        }
        cardStateLabel.text = state.uppercased()
        getCardData()
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut, animations: {
            self.ViewBack.transform = CGAffineTransform(scaleX: 1, y: -1)
        }, completion: nil)
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut, animations: {
            self.ViewBack.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func randomizeCard()
    {
        let randomDeckNum = Int(arc4random_uniform(UInt32(probabilityArray.count)))
        currDeck = probabilityArray[randomDeckNum] as! NSMutableArray
        currCardNum = Int(arc4random_uniform(UInt32(currDeck.count)))
        getCardData()
        preset_rating()
    }
    
    func animateButton(button: UIButton, expand: Bool)
    {
        if (expand == true)
        {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: nil)
        }
        else
        {
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut, animations: {
                button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
    
    func preset_rating()
    {
        if (currDeck == flashData.data.Rank1Words)
        {
            oneStarPress(Any.self)
        }
        else if (currDeck == flashData.data.Rank2Words)
        {
            twoStarPress(Any.self)
        }
        else
        {
            threeStarPress(Any.self)
        }
    }
    
    func getCardData()
    {
        cardImage.image = nil
        let valueMaker = currDeck[currCardNum]
        let cardTerm = (valueMaker as AnyObject).object(forKey: state) as? String
        if let cardImageVal = (valueMaker as AnyObject).value(forKeyPath: "image.url") as? String
        {
            if (state == "definition")
            {
                let imgURLString = cardImageVal
                let imgURL:URL = URL(string: imgURLString)!
                let imageData:NSData = NSData(contentsOf: imgURL)!
                cardImage.image = UIImage(data: imageData as Data)
            }
        }
        cardText.text = cardTerm
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "BackSegue")
        {
            let receiver = segue.destination as! HubViewController
            receiver.flashData = flashData
        }
    }

}
