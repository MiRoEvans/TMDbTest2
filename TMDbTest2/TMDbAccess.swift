//
//  TMDbAccess.swift
//  TMDbTest2
//
//  Created by Michael Evans on 7/18/20.
//  Copyright © 2020 MREink. All rights reserved.
//

import Foundation

class TMDbAccess {
    
    struct MovieResponses: Decodable {
        let results: [Movie]
    }
    
    struct Movie: Decodable {
        let overview: String
        let release_date: String
        let id: Int
        let original_title: String
        let title: String
        let popularity: Double
    }
    
    var movieResults = [Movie]()
    
    typealias JSONDictionary = [String: Any]
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionTask?
    
    var errorMessage = ""
    
    func getUrlFrom(_ urlString: String, urlQueryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        urlComponents.queryItems = urlQueryItems
        return urlComponents.url
    }
    
    func briefGetMovieSearchResults(usingUrl url: URL) {
        
        
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error
            in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
            let data = data,
            let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                let decodedData: MovieResponses = try! JSONDecoder().decode(MovieResponses.self, from: data)
                let results = decodedData.results
                for result in results {
                    print(result.title)
                }
            }
        }
        dataTask?.resume()
    }
    
    func getMovieSearchResults(usingUrl url: URL) {
        
        var responseJSON: JSONDictionary?
        
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error
            in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
            let data = data,
            let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let testResults: MovieResponses = try! JSONDecoder().decode(MovieResponses.self, from: data)
                let resultsArray = testResults.results
                
                print("----------\nTest results:\n\(testResults)\n-----------")

                do {
                    responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                } catch let parseError as NSError {
                    self?.errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                    return
                }
                print("Data...")
                if let printResponseJSON = responseJSON {
                    if let results = printResponseJSON["results"] {
                        // print("\nResults found.\n")
                        // print(results as! [JSONDictionary])
                        
                        let jsonResults = results as! [JSONDictionary]
                        
                        let itemNumber = jsonResults.count
                        
                        print ("Number of items: \(itemNumber)")
                        
                    }
                    print(printResponseJSON)
                }
                print(data)
                print("...")
            }
        }
        dataTask?.resume()
    }
    
}
