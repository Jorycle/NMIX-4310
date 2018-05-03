//
//  DataController.swift
//  MidtermProject
//
//  Created by Jorycle on 3/24/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import Foundation
import UIKit

struct FlashData {
    var Rank1Words: NSMutableArray = []
    var Rank2Words: NSMutableArray = []
    var Rank3Words: NSMutableArray = []
}

class DataController
{
    var data = FlashData()
    
    func loadData()
    {
        let r1words = loader(from: "RFCR1words.txt")
        let r2words = loader(from: "RFCR2words.txt")
        let r3words = loader(from: "RFCR3words.txt")
        
        stringToArray(from: r1words, to: self.data.Rank1Words)
        stringToArray(from: r2words, to: self.data.Rank2Words)
        stringToArray(from: r3words, to: self.data.Rank3Words)
    }
    
    func loader(from fileName: String) -> String
    {
        do {
        // get the documents folder url
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        // create the destination url for the text file to be saved
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        // reading from disk
        let savedText = try String(contentsOf: fileURL)
            return savedText
        }
        } catch {
            print("error:", error)
        }
        return ""
    }
    
    func stringToArray(from fileName: String, to array: NSMutableArray)
    {
        if (fileName.count > 0)
        {
            let data = fileName.data(using: String.Encoding.utf8)
            let temp = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableArray
            array.addObjects(from: temp as! [Any])
        }
    }
    
    func saver() {
        let rank1words = json(from: self.data.Rank1Words)
        let rank2words = json(from: self.data.Rank2Words)
        let rank3words = json(from: self.data.Rank3Words)
        fileSaver(from: rank1words!, to: "RFCR1words.txt")
        fileSaver(from: rank2words!, to: "RFCR2words.txt")
        fileSaver(from: rank3words!, to: "RFCR3words.txt")
    }
    
    func fileSaver(from object: String, to name: String)
    {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(name)
            try object.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
    
    func json(from object:Any) -> String? {
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: object)
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString
    }
    
    
}
