//
//  ViewController.swift
//  DemoMovieDB
//
//  Created by Dave Vo on 10/21/15.
//  Copyright © 2015 DaveVo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        MovieClient.getMovies { (movies, error) -> () in
//            
//            print("=================== Results ====================")
//            
//            for movie in movies! {
//                print("Title: \(movie.title)")
//                print("Poster: \(movie.poster)")
//            }
//            
//            print("done")
//        }
        
        MovieClient.getMovieDetail(150540) { (movie, error) -> () in
            print("=================== Results ====================")
            
            if movie != nil {
                print("Title: \(movie!.title)")
                print("Poster: \(movie!.poster)")
                print("Date: \(movie!.releaseDate)")
                print("Overview: \(movie!.overview)")
                print("Vote: \(movie!.voteAverage)")
            }
            
            print("done")
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
    
    @IBAction func onButton(sender: UIButton) {
//        UIApplication.sharedApplication().openURL("https://www.youtube.com/watch?v=1t0A_tZGrYw")
        
        var url = NSURL(string:"youtube://1t0A_tZGrYw")!
        if UIApplication.sharedApplication().canOpenURL(url)  {
            UIApplication.sharedApplication().openURL(url)
        } else {
            url = NSURL(string:"https://youtu.be/1t0A_tZGrYw")!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    


}

