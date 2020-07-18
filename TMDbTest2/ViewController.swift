//
//  ViewController.swift
//  TMDbTest2
//
//  Created by Michael Evans on 7/18/20.
//  Copyright © 2020 MREink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let testTMDbAccess = TMDbAccess()
        
        let getSearchMovie = "https://api.themoviedb.org/3/search/movie"
        
        var nameValueItems = [TMDbAccess.NameValueItem(name: "api_key", value: "1031f0ae64b4fe83395ca26c12f7c810")]
        
        nameValueItems.append(TMDbAccess.NameValueItem(name: "query", value: "batman"))
        
        let testResult = testTMDbAccess.getUrlFrom(getSearchMovie, nameValueItems: nameValueItems)
        
        guard let getTheString = testResult?.absoluteString else {
            return
        }
        print(getTheString)
        
    }


}

