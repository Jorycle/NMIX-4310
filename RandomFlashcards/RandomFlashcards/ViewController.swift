//
//  ViewController.swift
//  MidtermProject
//
//  Created by Joseph Clements on 2/22/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassGo"
        {
            let receiver = segue.destination as! HubViewController
            let newData = DataController()
            newData.loadData()
            receiver.flashData = newData
        }
    }
}

