//
//  Video.swift
//  Pixabay
//
//  Created by Zhandos Bolatbekov on 4/7/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import Alamofire

struct Video {
    typealias JSON = [String : Any]
    
    var previewURL = ""
    var mediumVideoURL = ""
    var tags = ""
    
    static func search(query: String, completion: @escaping([Video]) -> Void) {
        var videos: [Video] = []
        
        let url = "https://pixabay.com/api/videos/?key=8613810-bb899408f26e2c5c5b52e0b10&q=\(query)&pretty=true"
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! JSON
                let hits = json["hits"] as! [JSON]
                for hit in hits {
                    let pictureID = hit["picture_id"] as! String
                    let previewURL = "https://i.vimeocdn.com/video/\(pictureID)_295x166.jpg"
                    
                    let videoJSON = hit["videos"] as! JSON
                    let medium = videoJSON["medium"] as! JSON
                    let mediumVideoURL = medium["url"] as! String
            
                    let tags = hit["tags"] as! String
                    
                    let video = Video(previewURL: previewURL, mediumVideoURL: mediumVideoURL, tags: tags)
                    videos.append(video)
                }
                completion(videos)
            case .failure(let error):
                print("error: ", error.localizedDescription)
                completion([])
            }
        }
    }
}
