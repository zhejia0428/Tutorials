//
//  LibraryAPI.swift
//  BlueLibrarySwift
//
//  Created by Zhe Jia on 7/6/17.
//  Copyright © 2017 Raywenderlich. All rights reserved.
//

import Foundation

class LibraryAPI {
    class var sharedInstance: LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    
    var httpClient: HTTPClient
    var persistenceManager: PersistenceManager
    var isOnLine: Bool
    
    init() {
        self.httpClient = HTTPClient()
        self.persistenceManager = PersistenceManager()
        self.isOnLine = false
    }
    
    func getAlbums() -> [Album] {
        return persistenceManager.getAlbum()
    }
    
    func addAlbum(album: Album, index: Int) {
        persistenceManager.addAlbum(album: album, index: index)
        if isOnLine {
            httpClient.postRequest("/api/addAlbum", body: album.description)
        }
    }
    
    func deleteAlbum(index: Int) {
        persistenceManager.deleteAlbumAtIndex(index: index)
        if isOnLine {
            httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }
    
}
