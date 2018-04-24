//
//  Storage.swift
//  Pixabay
//
//  Created by Zhandos Bolatbekov on 4/11/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import Cache

private struct Caches {
    static let jsonCache = try! Cache.Storage(diskConfig: DiskConfig(name: "JSON Cache"),
                                              memoryConfig: MemoryConfig())
}

private struct Keys {
    static let favoriteImages = "Favorite Images"
    static let favoriteVideos = "Favorite Videos"
}

struct Storage {
    static var favoriteImages: [Image] {
        get {
            do {
                return try Caches.jsonCache.object(ofType: [Image].self, forKey: Keys.favoriteImages)
            } catch {
                return []
            }
        }
        set {
            do {
                try Caches.jsonCache.setObject(newValue, forKey: Keys.favoriteImages)
            } catch {
                
            }
        }
    }
    static var favoriteVideos: [Video] {
        get {
            do {
                return try Caches.jsonCache.object(ofType: [Video].self, forKey: Keys.favoriteVideos)
            } catch {
                return []
            }
        }
        set {
            do {
                try Caches.jsonCache.setObject(newValue, forKey: Keys.favoriteVideos)
            } catch {
                
            }
        }
    }
}
