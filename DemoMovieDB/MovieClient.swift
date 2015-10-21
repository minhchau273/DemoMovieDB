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
    //    static let sharedInstance = MovieClient()
    
    static func getMovies(completion: (results: NSArray?, error: NSError?) -> ()) {
        var urlString = "http://api.themoviedb.org/3/movie/upcoming"
        
        urlString = addApiKey(urlString)
        
        
        //The Url that will be called
        let url = NSURL(string: urlString)
        
        let request = NSMutableURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                print("===================\nresponse\n===================")
                print(response)
                print("===================\ndata\n===================")
                //                print(String(data: data, encoding: NSUTF8StringEncoding))
                
                
                //Serialize the JSON result into a dictionary
                let jsonResult: NSDictionary! = try! NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
                //If there is a result add the data into an array
                if jsonResult.count>0 && jsonResult["results"]!.count > 0 {
                    
                    let results: NSArray = jsonResult["results"]! as! NSArray
                    //Use the completion handler to pass the results
                    completion(results: results, error: nil)
                } else {
                    print("error")
                    completion(results: nil, error: error)
                }
                
                
                
            } else {
                print("===================\nerror\n===================")
                print(error)
                completion(results: nil, error: error)
            }
        }
        
        task.resume()
        
    }
    
    private static func addApiKey(urlString: String) -> String {
        return urlString + "?api_key=" + apiKey
    }
}
