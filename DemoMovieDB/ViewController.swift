//
//  ViewController.swift
//  DemoMovieDB
//
//  Created by Dave Vo on 10/21/15.
//  Copyright © 2015 DaveVo. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
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
        
        //        MovieClient.getMovieDetail(150540) { (movie, error) -> () in
        //            print("=================== Results ====================")
        //
        //            if movie != nil {
        //                print("Title: \(movie!.title)")
        //                print("Poster: \(movie!.poster)")
        //                print("Date: \(movie!.releaseDate)")
        //                print("Overview: \(movie!.overview)")
        //                print("Vote: \(movie!.voteAverage)")
        //
        //                MovieClient.getTrailers(movie!, completion: { (trailers, error) -> () in
        //                    if trailers != nil {
        //                        for trailer in trailers! {
        //                            movie!.trailers.append(trailer)
        //                        }
        //                    }
        //                })
        //
        //                for trailer in movie!.trailers {
        //                    print("Trailer: \(trailer.name)")
        //                }
        //            }
        //
        //            print("done")
        //        }
        
        //        let movie = MovieClient.getMovieWithTrailers(150540)
        //
        //        print("Title: \(movie!.title)")
        //        print("Poster: \(movie!.poster)")
        //        print("Date: \(movie!.releaseDate)")
        //        print("Overview: \(movie!.overview)")
        //        print("Vote: \(movie!.voteAverage)")
        //
        //        for trailer in movie!.trailers {
        //            print("Trailer: \(trailer.name)")
        //        }
        
        
        //        MovieClient.getMovies2 { (movies, error) -> () in
        //            print("=================== Results ====================")
        //
        //                        for movie in movies! {
        //                            print("Title: \(movie.title)")
        //                            print("Poster: \(movie.poster)")
        //                        }
        //            print("done")
        //        }
        
        //        MovieClient.getMovieDetail2(150540) { (movie, error) -> () in
        //            print("=================== Results ====================")
        //            
        //            if movie != nil {
        //                print("Title: \(movie!.title)")
        //                print("Poster: \(movie!.poster)")
        //                print("Date: \(movie!.releaseDate)")
        //                print("Overview: \(movie!.overview)")
        //                print("Vote: \(movie!.voteAverage)")
        //                
        //                MovieClient.getTrailers2(movie!, completion: { (trailers, error) -> () in
        //                    for trailer in trailers! {
        //                        print("Trailer: \(trailer.name)")
        //                    }
        //                })
        //            }
        //        }
        
        MovieClient.getMovieWithTrailers2(150540) { (movie, error) -> () in
            if movie != nil {
                
                print("Title: \(movie!.title)")
                print("Poster: \(movie!.poster)")
                print("Date: \(movie!.releaseDate)")
                print("Overview: \(movie!.overview)")
                print("Vote: \(movie!.voteAverage)")
                
                for trailer in movie!.trailers {
                    print("Trailer: \(trailer.name)")
                }
                
                let imgUrl = NSURL(string: movie!.poster)
                self.imageView.af_setImageWithURL(imgUrl!)
            }
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onButton(sender: UIButton) {
        var url = NSURL(string:"youtube://_MC3XuMvsDI")!
        if UIApplication.sharedApplication().canOpenURL(url)  {
            UIApplication.sharedApplication().openURL(url)
        } else {
            url = NSURL(string:"https://youtu.be/_MC3XuMvsDI")!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
    
}

