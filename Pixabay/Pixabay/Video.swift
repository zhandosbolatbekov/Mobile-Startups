//
//  Video.swift
//  Pixabay
//
//  Created by Zhandos Bolatbekov on 4/7/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import Alamofire

struct Video: Codable {
    typealias JSON = [String : Any]
    
    var id = 0
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
                    let id = hit["id"] as! Int
                    let previewURL = "https://i.vimeocdn.com/video/\(pictureID)_295x166.jpg"
                    let videoJSON = hit["videos"] as! JSON
                    let medium = videoJSON["medium"] as! JSON
                    let mediumVideoURL = medium["url"] as! String
            
                    let tags = hit["tags"] as! String
                    
                    let video = Video(id: id, previewURL: previewURL, mediumVideoURL: mediumVideoURL, tags: tags)
                    videos.append(video)
                }
                completion(videos)
            case .failure(let error):
                print("error: ", error.localizedDescription)
                completion([])
            }
        }
    }
    
    static func addToFavorites(video: Video) {
        var favoriteVideos = Storage.favoriteVideos.filter { $0 != video }
        favoriteVideos.insert(video, at: 0)
        Storage.favoriteVideos = favoriteVideos
    }
}

extension Video: Equatable {
    static func == (lhs: Video, rhs: Video) -> Bool {
        return lhs.id == rhs.id
    }
}
