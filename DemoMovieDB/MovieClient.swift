//
//  MovieClient.swift
//  DemoMovieDB
//
//  Created by Dave Vo on 10/21/15.
//  Copyright © 2015 DaveVo. All rights reserved.
//

import UIKit

class MovieClient: NSObject {
    
    static var apiKey: String!
    
    static func getMovies(completion: (movies: [Movie]?, error: NSError?) -> ()) {
        var urlString = "http://api.themoviedb.org/3/movie/upcoming"
//        var urlString = "http://api.themoviedb.org/3/review/150540"
        
        urlString = addApiKey(urlString)
        
        
        //The Url that will be called
        let url = NSURL(string: urlString)
        
        let request = NSMutableURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                print("===================\nresponse\n===================")
                print(response)
                
                //Serialize the JSON result into a dictionary
                let jsonResult: NSDictionary! = try! NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
                //If there is a result add the data into an array
//                if jsonResult.count>0 && jsonResult["results"]!.count > 0 {
                if let results = jsonResult["results"] {
                    
//                    let results: NSArray = jsonResult["results"]! as! NSArray
                    //Use the completion handler to pass the results
                    
                    let movies = Movie.moviesWithArray(results as! [NSDictionary])
                    completion(movies: movies, error: nil)
                } else {
                    print("error")
                    completion(movies: nil, error: error)
                }
                
                
            } else {
                print("===================\nerror\n===================")
                print(error)
                completion(movies: nil, error: error)
            }
        }
        
        task.resume()
        
    }
    
    static func getMovieDetail(id: Int, completion: (movie: Movie?, error: NSError?) -> ()) {
        var urlString = "http://api.themoviedb.org/3/movie/\(id)"
        
        urlString = addApiKey(urlString)
        
        let url = NSURL(string: urlString)
        
        let request = NSMutableURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                print("===================\nresponse\n===================")
                print(response)
                
                let jsonResult: NSDictionary! = try! NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
                let movie = Movie(dictionary: jsonResult, isFull: true)
                completion(movie: movie, error: nil)
                
//                if let results = jsonResult["results"] {
//                    
//                    let movies = Movie.moviesWithArray(results as! [NSDictionary])
//                    completion(movies: movies, error: nil)
//                } else {
//                    print("error")
//                    completion(movie: nil, error: error)
//                }
                
                
            } else {
                print("===================\nerror\n===================")
                print(error)
                completion(movie: nil, error: error)
            }
        }
        
        task.resume()
        
    }
    
    private static func addApiKey(urlString: String) -> String {
        return urlString + "?api_key=" + apiKey
    }
}
