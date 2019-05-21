//
//  VideoModel.swift
//  YoutubeApp
//
//  Created by Ramapriya Ranganath on 6/26/17.
//  Copyright © 2017 Ramapriya Ranganath. All rights reserved.
//

import UIKit
import Alamofire

public protocol VideoModelDelegate
{
    func dataReady()
}

class VideoModel: NSObject {
    
    
    
    let urladdress = "https://www.googleapis.com/youtube/v3/playlistItems"
    
    let API_KEY = "AIzaSyAKYxf9GFeU3aBpD_RHa__1KNZDui0fZO8"
    let UPLOADS_PLAYLIST_ID = "PLqDHF2tkRWOpNx10AIZkrZrwiHcVLcHo3"
    //let UPLOADS_PLAYLIST_ID = "UU2D6eRvCeMtcF5OGHf1-trw"
    //let CHANNEL_ID = "UC2D6eRvCeMtcF5OGHf1-trw"
    let CHANNEL_ID = "UCDhqADfY8S2N8BfrffZAc2w"
    
    
    var videoArray = [Video]()
    
    var delegate: VideoModelDelegate?
    
    func getFeedVideos() {
        
        
        let param = ["part":"snippet","channelId":CHANNEL_ID,"playlistId":UPLOADS_PLAYLIST_ID,"key":API_KEY]
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/playlists", parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            
            var arrayOfVideos = [Video]()

            
            if let JSON = response.result.value  as?  [String : Any] {
                    if let items =  JSON["items"] as? [[String : Any]] {
                    for video in items {
                        print(video)
                        
                        // TODO Create video objects off of the JSON response
                        let videoObj = Video()
                        //VideoId
                        videoObj.videoId = (video as AnyObject).value(forKey:"id") as! String
                        
                        //Video Title
                        let test = (video as AnyObject).value(forKey: "snippet") as! NSDictionary
                        //print(test)
                        videoObj.videoTitle=(test as AnyObject).value(forKey: "title") as! String
                        
                        //Video Description
                        let pqr = (test as AnyObject).value(forKey:"localized") as! NSDictionary
                        //print(pqr)
                        videoObj.videoDescription = (pqr as AnyObject).value(forKey: "description") as! String
                        
                        //Video ThumbnailUrl
                        let abc = (test as AnyObject).value(forKey:"thumbnails") as! NSDictionary
                       // print(abc)
                        let xyz = (abc as AnyObject).value(forKey: "medium") as! NSDictionary
                        videoObj.videoThumbnailUrl = (xyz as AnyObject).value(forKey: "url") as! String
                       
                        
                        arrayOfVideos.append(videoObj)
                        
                    }
                   
                    
                }
            }
            
            
            self.videoArray = arrayOfVideos
            if self.delegate != nil {
                
                self.delegate?.dataReady()
                //func dataReady(){}
                
                
            }
            
        }
    }
    func getVideos() -> [Video] {
        var videos = [Video]()
        
        let video1 = Video()
        video1.videoId = "M7CjDCqY9Gk"
        video1.videoTitle = "X-Men Apocalypse Cast stops by Nasdaq"
        video1.videoDescription = "The stars of X-Men: Apocalypse including Evan Peters, Alex Shipp, Lana Condor and Tye Sheridan stopped by Nasdaq to share the behind-the-scenes scoop and what they enjoyed about working on the movie."
        videos.append(video1)

        let video2 = Video()
        video2.videoId = "v3oCcaOHA4w"
        video2.videoTitle = "The Millennial Report: on Cooking"
        video2.videoDescription = "Brad and Meg break down their cooking habits, inspiration, and some of the key companies you may or may not realize are involved."
        videos.append(video2)
        
        
        let video3 = Video()
        video3.videoId = "mTiBPg7-85g"
        video3.videoTitle = "Pippa Mann talks Indy500 and rings Nasdaq Closing Bell"
        video3.videoDescription = "Pippa Mann stops by Nasdaq before the closing bell to talk ‎Indy500, Breast Cancer Awareness, and the Business side of Professional Race Car Driving."
        videos.append(video3)
        
        let video4 = Video()
        video4.videoId = "LL6V0CJs62o"
        video4.videoTitle = "Deepak Chopra Launches JIYO Healthy Living Content Platform"
        video4.videoDescription = "Deepak Chopra stops by Nasdaq to talk the important of employee wellness, millennials' causes of stress, and his latest content platform, JIYO."
        videos.append(video4)
        
        let video5 = Video()
        video5.videoId = "6pA08SB5rP0"
        video5.videoTitle = "#NasdaqExclusives: Coca Rocha, DKMS Ambassador"
        video5.videoDescription = "Model Coca Rocha joins us at Nasdaq for an interview regarding her work with the international non-profit organization DKMS and their mission in deleting blood cancer."
        videos.append(video5)
        
        return videos
    }

}
