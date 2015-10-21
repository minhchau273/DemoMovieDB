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
        
        MovieClient.getMovies { (results, error) -> () in
            
            print("=================== Results ====================")
            print(results)
            
            print("done")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

