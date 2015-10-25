//
//  Movie.swift
//  DemoMovieDB
//
//  Created by EastAgile16 on 10/22/15.
//  Copyright © 2015 DaveVo. All rights reserved.
//

import RealmSwift

class Movie: RealmObject {

    var originalId: Int!
    var title: String!
    var poster: String!
    var releaseDate: NSDate!
    var overview: String!
    var voteAverage: Double!
    
    let trailers = List<Trailer>()
    
    convenience init(dictionary: NSDictionary, isFull: Bool) {
        self.init()
        
        originalId = dictionary["id"] as? Int!
        title = dictionary["title"] as? String!
        
        if let posterPath = dictionary["poster_path"] as? String! {
            poster = "http://image.tmdb.org/t/p/w500" + posterPath
        }
        
        if isFull {
            let releaseDateString = dictionary["release_date"] as? String!
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            releaseDate = formatter.dateFromString(releaseDateString!)
            
            overview = dictionary["overview"] as? String!
            voteAverage = dictionary["vote_average"] as? Double!
         }
    }
    
    static func moviesWithArray(array: [NSDictionary]) -> [Movie] {
        var movies = [Movie]()
        
        for dictionary in array {
            movies.append(Movie(dictionary: dictionary, isFull: false))
        }
        
        return movies
    }

    
}
