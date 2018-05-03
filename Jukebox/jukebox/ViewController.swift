//
//  ViewController.swift
//  Jukebox
//
//  Created by Joseph Clements on 3/22/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var AlbumTitle: UILabel!
    @IBOutlet weak var SongProgress: UIProgressView!
    @IBOutlet weak var MusicTable: UITableView!
    @IBOutlet weak var ArtistTitle: UILabel!
    @IBOutlet weak var AlbumArt: UIImageView!
    @IBOutlet weak var SongTitleLabel: UILabel!
    var musicDatabase: NSArray = []
    var currentSelection = 0
    var player = AVPlayer()
    var selectedSongURL: URL!
    func change_table_select()
    {
        let indexPath = IndexPath(row: currentSelection, section: 0)
        self.MusicTable.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        self.tableView(self.MusicTable, didSelectRowAt: indexPath)
    }
    
    @IBAction func BackButton(_ sender: Any) {
        if (currentSelection > 0)
        {
            currentSelection -= 1
            change_table_select()
        }
    }
    
    @IBAction func NextButton(_ sender: Any) {
        if (currentSelection < musicDatabase.count - 1)
        {
            currentSelection += 1
            change_table_select()
        }
    }
    
    @IBAction func PlayButton(_ sender: Any) {
        let playeritem = AVPlayerItem(url: selectedSongURL)
        player = AVPlayer(playerItem: playeritem)
        player.play()
        player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1/30.0, Int32(NSEC_PER_SEC)), queue: nil, using: { time in
            let duration = CMTimeGetSeconds(playeritem.duration)
            self.SongProgress.progress = Float((CMTimeGetSeconds(time)/duration))
        })
    }
    
    @IBAction func StopButton(_ sender: Any) {
        player.seek(to: CMTimeMake(0, 1))
        player.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MusicTable.dataSource = self
        MusicTable.delegate = self
        loadMusicData()
        change_table_select()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scraper = musicDatabase[indexPath.row]
        currentSelection = indexPath.row
        ArtistTitle.text = (scraper as AnyObject)["artistName"] as? String
        AlbumTitle.text = (scraper as AnyObject)["collectionName"] as? String
        let imageURL = (scraper as AnyObject)["artworkUrl100"] as? String
        let imgURL:URL = URL(string: imageURL!)!
        let imageData:NSData = NSData(contentsOf: imgURL)!
        AlbumArt.image = UIImage(data: imageData as Data)
        SongTitleLabel.text = (scraper as AnyObject)["name"] as? String
        let songID = (scraper as AnyObject)["id"] as? String
        let songURL = NSURL(string: "https://itunes.apple.com/us/lookup?id=" + songID!)
        let theSongData = NSData(contentsOf: songURL! as URL)
        let json = try! JSONSerialization.jsonObject(with: theSongData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        selectedSongURL = URL(string:(json.value(forKeyPath: "results.previewUrl") as! [String]).joined())!
        StopButton(Any.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicDatabase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songTableCell") as! SongTableCell
        let scraper = musicDatabase[indexPath.row]
        let songName = (scraper as AnyObject)["name"] as? String
        let artist = (scraper as AnyObject)["artistName"]
        let album = (scraper as AnyObject)["collectionName"]
        cell.ArtistAlbum.text = artist as! String + " - " + (album as! String)
        cell.SongName.text = "\"" + songName! + "\""
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor(red: 0.6, green: 0.01, blue: 0.2, alpha: 1).cgColor
        
        return cell
    }
    
    func loadMusicData()
    {
        let dataURL = NSURL(string: "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/10/explicit.json")
        //let dataURL = NSURL(string: "https://itunes.apple.com/us/rss/topsongs/limit=10/genre=5/json")
        let theData = NSData(contentsOf: dataURL! as URL)
        let json = try! JSONSerialization.jsonObject(with: theData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        let feed = json["feed"] as! NSDictionary
        self.musicDatabase = feed["results"] as! NSArray
    }
    
}

