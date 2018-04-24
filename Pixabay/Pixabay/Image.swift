//
//  Image.swift
//  Pixabay
//
//  Created by Zhandos Bolatbekov on 4/7/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import Alamofire

struct Image: Codable {
    var id = 0
    var previewURL = ""
    var webformatURL = ""
    var tags = ""
    
    static func search(query: String, completion: @escaping([Image]) -> Void) {
        var images: [Image] = []
        
        let url = URL(string: "https://pixabay.com/api/?key=8613810-bb899408f26e2c5c5b52e0b10&q=\(query)&image_type=photo")!
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String : Any]
                let hits = json["hits"] as! [[String : Any]]
                for hit in hits {
                    let id = hit["id"] as! Int
                    let previewURL = hit["previewURL"] as! String
                    let webformatURL = hit["webformatURL"] as! String
                    let tags = hit["tags"] as! String
                    let image = Image(id: id, previewURL: previewURL, webformatURL: webformatURL, tags: tags)
                    images.append(image)
                }
                completion(images)
            case .failure(let error):
                print("error: ", error.localizedDescription)
                completion([])
            }
        }
    }
    
    static func addToFavorites(image: Image) {
        var favoriteImages = Storage.favoriteImages.filter { $0 != image }
        favoriteImages.insert(image, at: 0)
        Storage.favoriteImages = favoriteImages
    }
}

extension Image: Equatable {
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.id == rhs.id
    }
}
