//
//  ViewController.swift
//  TMDbTest2
//
//  Created by Michael Evans on 7/18/20.
//  Copyright © 2020 MREink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel:UILabel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textLabel?.text = "IBOutlet"
        
        let testTMDbAsker = TMDbAsker()
        
        
        testTMDbAsker.getMoviesUsingSearchString("batwoman")
        
        testTMDbAsker.getActorsUsingSearchString("ford")
        
        testTMDbAsker.getMovieDetailUsingId(21683)
        
        testTMDbAsker.getMovieCastUsingId(21683)
        
        testTMDbAsker.getActorDetailUsingId(2)
        
        testTMDbAsker.getActorDetailUsingId(3)
        
        
//        let testTMDbAccess = TMDbAccess()
//
//        let getSearchMovie = "https://api.themoviedb.org/3/search/movie"
//
//        var urlQueryItems = [URLQueryItem(name: "api_key", value: "1031f0ae64b4fe83395ca26c12f7c810")]
//
//        urlQueryItems.append(URLQueryItem(name: "query", value: "batwoman"))
//
//        let testResult = testTMDbAccess.getUrlFrom(getSearchMovie, urlQueryItems: urlQueryItems)
//
//        guard let getTheString = testResult?.absoluteString else {
//            return
//        }
//        print(getTheString)
//
//        if let useUrl = testResult {
//            testTMDbAccess.briefGetMovieSearchResults(usingUrl: useUrl)
//            // testTMDbAccess.getMovieSearchResults(usingUrl: useUrl)
//        }
//
//        print("\n***\nError message:\n\(testTMDbAccess.errorMessage)\n***\n")
        
        
    }


}

