//
//  MovieClient.swift
//  DemoMovieDB
//
//  Created by Dave Vo on 10/21/15.
//  Copyright © 2015 DaveVo. All rights reserved.
//

import UIKit
import Alamofire

class MovieClient: NSObject {
    
    static var apiKey: String!
       
    static func getMovies2(completion: (movies: [Movie]?, error: NSError?) -> ()) {
        let urlString = "http://api.themoviedb.org/3/movie/upcoming"
        
        var param = [String: AnyObject]()
        param["api_key"] = apiKey
        
        Alamofire.request(.GET, urlString, parameters: param).responseJSON { response in
            print("original request: \(response.request)")
            print("response: \(response.response)")
            print("server data: \(response.data)")
            print("result: \(response.result)")
            
            
            if let json = response.result.value as? NSDictionary {
                //                print("JSON: \(json)")
                
                if let results = json["results"] {
                    
                    let movies = Movie.moviesWithArray(results as! [NSDictionary])
                    completion(movies: movies, error: nil)
                }
                
                
            } else {
                completion(movies: nil, error: response.result.error)
                print("error: \(response.result.error)")
            }
        }
        
        
        
    }
    
    static func getMovieDetail2(id: Int, completion: (movie: Movie?, error: NSError?) -> ()) {
        let urlString = "http://api.themoviedb.org/3/movie/\(id)"
        print("get movie detail 2")
        var params = [String: AnyObject]()
        params["api_key"] = apiKey
        
        Alamofire.request(.GET, urlString, parameters: params).responseJSON { response in
            
            if let json = response.result.value as? NSDictionary {
                let movie = Movie(dictionary: json, isFull: true)
                completion(movie: movie, error: nil)
            } else {
                completion(movie: nil, error: response.result.error)
                print("Error when getting movie's details: \(response.result.error)")
            }
        }
        
    }
    
    
    static func getTrailers2(movie: Movie, completion: (trailers: [Trailer]?, error: NSError?) -> ()) {
        let urlString = "http://api.themoviedb.org/3/movie/\(movie.originalId)/videos"
        print("get trailer 2")
        var params = [String: AnyObject]()
        params["api_key"] = apiKey
        
        Alamofire.request(.GET, urlString, parameters: params).responseJSON {
            response in
            
            if let json = response.result.value as? NSDictionary {
                if let results = json["results"] {
                    let trailers = Trailer.trailersWithArray(results as! [NSDictionary], movie: movie)
                    completion(trailers: trailers, error: nil)
                }
            } else {
                completion(trailers: nil, error: response.result.error)
                print("Error when getting trailers: \(response.result.error)")
            }
        }
        
    }
    
    static func getMovieWithTrailers2(id: Int, completion: (movie: Movie?, error: NSError?) -> ()) {
        
        getMovieDetail2(id) { (movie, error) -> () in
            if movie != nil {
                getTrailers2(movie!, completion: { (trailers, error) -> () in
                    if trailers != nil {
                        for trailer in trailers! {
                            movie!.trailers.append(trailer)
                        }
                        completion(movie: movie, error: nil)
                    } else {
                        completion(movie: nil, error: error)
                    }
                })
            } else {
                completion(movie: nil, error: error)
            }
        }
    }
    
    
}
