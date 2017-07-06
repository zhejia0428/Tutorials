//
//  Album.swift
//  BlueLibrarySwift
//
//  Created by Zhe Jia on 7/6/17.
//  Copyright © 2017 Raywenderlich. All rights reserved.
//

import Foundation

class Album {
    var title: String
    var artist: String
    var genre: String
    var coverUrl: String
    var year: String
    
    init(title: String, artist: String, genre: String, coverUrl: String, year: String) {
        self.title = title
        self.artist = artist
        self.genre = genre
        self.coverUrl = coverUrl
        self.year = year
    }
}


extension Album: CustomStringConvertible {
    var description: String {
        return "title: \(self.title)" + "artist: \(self.artist)" + "genre: \(self.genre)" + "coverUrl: \(self.coverUrl)" + "year: \(self.year)"
    }
}
