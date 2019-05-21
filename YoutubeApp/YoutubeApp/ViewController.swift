//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Ramapriya Ranganath on 6/26/17.
//  Copyright © 2017 Ramapriya Ranganath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, VideoModelDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var videos:[Video] = [Video]()
    var selectedVideo:Video = Video()
    let  model:VideoModel = VideoModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.model.delegate = self as? VideoModelDelegate
        //let model = VideoModel()
        //self.videos = model.getVideos()
        model.getFeedVideos()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReady() {
        self.videos = self.model.videoArray
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return (self.view.frame.size.width / 320) * 180
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        let videoTitle = videos[indexPath.row].videoTitle
        
        let label = cell.viewWithTag(2) as! UILabel
        label.text = videoTitle
        
        //cell.textLabel?.text = videoTitle
        
        // Construct the video thumbnain url
        let videoThumbnailUrlString =  videos[indexPath.row].videoThumbnailUrl
        //let videoThumbnailUrlString = "http://i1.ytimg.com/vi/" + videos[indexPath.row].videoId + "/mqdefault.jpg"
        
        // Create an NSURLobject
        let videoThumbailUrl = URL(string: videoThumbnailUrlString)
        
        if videoThumbailUrl != nil {
            
            // Create an NSURLRequest object
            let request = URLRequest(url: videoThumbailUrl!)
            
            //Create an NSURLSesson
            let session = URLSession.shared
            
            // Create a datatask and pass in the request
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                
                DispatchQueue.main.async {
                    // Get a reference to the imageview element fo the cell
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    
                    // Create an image object from the data and asign it into the imageview
                    imageView.image = UIImage(data: data!)
                }
                
            })
            dataTask.resume()
        
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedVideo = self.videos[indexPath.row]
        
        self.performSegue(withIdentifier: "goToDetail", sender: self)
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! VideoDetailViewController
        detailViewController.selectedVideo = self.selectedVideo

        
        
    }
    
}

