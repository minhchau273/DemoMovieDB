//
//  Trailer.swift
//  DemoMovieDB
//
//  Created by EastAgile16 on 10/22/15.
//  Copyright © 2015 DaveVo. All rights reserved.
//

import UIKit

class Trailer: RealmObject {
    var name: String?
    var key: String?
    var movie: Movie?
    
    convenience init(dictionary: NSDictionary, movie: Movie) {
        self.init()
        name = dictionary["name"] as? String!
        key = dictionary["key"] as? String!
        self.movie = movie
    }
    
//    func getYouTubeUrl() -> String {
//        return "youtube://" + key!
//    }
//    
//    func getSafariUrl() -> String {
//        return "https://youtu.be/" + key!
//    }
    
    static func trailersWithArray(array: [NSDictionary], movie: Movie) -> [Trailer] {
        var trailers = [Trailer]()
        
        for dictionary in array {
            trailers.append(Trailer(dictionary: dictionary, movie: movie))
        }
        
        return trailers
    }
    
}

// MARK: - Computed properties
extension Trailer {
    var youTubeUrl: String? {
        return "youtube://" + key!
    }
    
    var safariUrl: String? {
        return "https://youtu.be/" + key!
    }
}
