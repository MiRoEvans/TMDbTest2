//
//  TMDbAsker.swift
//  TMDbTest2
//
//  Created by Michael Evans on 7/20/20.
//  Copyright © 2020 MREink. All rights reserved.
//

import Foundation

class TMDbAsker {
    
    let defaultSession = URLSession(configuration: .default)
//    var dataTask: URLSessionTask?
    var errorMessage = ""
    
    var apiKeyUrlQueryItem = URLQueryItem(name: "api_key", value: "1031f0ae64b4fe83395ca26c12f7c810")
    
    struct MovieResponses: Decodable {
        let results: [FoundMovie]
    }
    
    struct ActorResponses: Decodable {
        let results: [FoundActor]
    }
    
    struct CastResponses: Decodable {
        let id: Int
        let cast: [Cast]
    }
    
    struct FoundActor: Decodable {
        let id: Int
        let name: String
        let popularity: Double
    }
    
    struct FoundMovie: Decodable {
        let release_date: String
        let id: Int
        let original_title: String
        let title: String
        let popularity: Double
    }
    
    struct Movie: Decodable {
        let overview: String
        let release_date: String
        let id: Int
        let original_title: String
        let title: String
        let popularity: Double
    }
    
    struct Actor: Decodable {
        let birthday: String
        let id: Int
        let name: String
        let popularity: Double
    }
    
    struct Cast: Decodable {
        let cast_id: Int
        let character: String
        let credit_id: String
        let id: Int
        let name: String
    }
    
    func getActorDetailUsingId(_ id: Int) {
        let detailActorUrl = "https://api.themoviedb.org/3/person/\(id)"
        
        var urlQueryItems = [URLQueryItem]()
        // Start urlQueryItems with API key.
        urlQueryItems.append(apiKeyUrlQueryItem)
        
        if let fullUrl = getUrlFrom(detailActorUrl, urlQueryItems: urlQueryItems) {
            requestTMDbActorDetails(usingUrl: fullUrl)
        }
    }
    
    func getMovieCastUsingId(_ id: Int) {
        let castMovieUrl = "https://api.themoviedb.org/3/movie/\(id)/credits"
        
        var urlQueryItems = [URLQueryItem]()
        // Start urlQueryItems with API key.
        urlQueryItems.append(apiKeyUrlQueryItem)
        
        if let fullUrl = getUrlFrom(castMovieUrl, urlQueryItems: urlQueryItems) {
            requestTMDbMovieCast(usingUrl: fullUrl)
        }
    }
    
    func getMovieDetailUsingId(_ id: Int) {
        let detailMovieUrl = "https://api.themoviedb.org/3/movie/\(id)"
        
        var urlQueryItems = [URLQueryItem]()
        // Start urlQueryItems with API key.
        urlQueryItems.append(apiKeyUrlQueryItem)
        
        if let fullUrl = getUrlFrom(detailMovieUrl, urlQueryItems: urlQueryItems) {
            requestTMDbMovieDetails(usingUrl: fullUrl)
        }
    }
    
    func getMoviesUsingSearchString(_ searchString: String) {
        let searchMovieUrl = "https://api.themoviedb.org/3/search/movie"
        
        var urlQueryItems = [URLQueryItem]()
        // Start urlQueryItems with API key.
        urlQueryItems.append(apiKeyUrlQueryItem)
        // Add query search string.
        urlQueryItems.append(URLQueryItem(name: "query", value: searchString))
        
        if let fullUrl = getUrlFrom(searchMovieUrl, urlQueryItems: urlQueryItems) {
            requestTMDbMoviesResults(usingUrl: fullUrl)
        }
    }
    
    func getActorsUsingSearchString(_ searchString: String) {
        let searchActorUrl = "https://api.themoviedb.org/3/search/person"
        
        var urlQueryItems = [URLQueryItem]()
        // Start urlQueryItems with API key.
        urlQueryItems.append(apiKeyUrlQueryItem)
        // Add query search string.
        urlQueryItems.append(URLQueryItem(name: "query", value: searchString))
        
        if let fullUrl = getUrlFrom(searchActorUrl, urlQueryItems: urlQueryItems) {
            requestTMDbActorsResults(usingUrl: fullUrl)
        }
    }
    
    private func getUrlFrom(_ urlString: String, urlQueryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        urlComponents.queryItems = urlQueryItems
        return urlComponents.url
    }
    
    private func requestTMDbMovieCast(usingUrl url: URL) {
        var funcDataTask: URLSessionTask? = defaultSession.dataTask(with: url) { [weak self] data, response, error
            in
            defer {
                print("defer -- \(url)")
                // self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let results = try JSONDecoder().decode(CastResponses.self, from: data)
                    for result in results.cast {
                        print(result.character)
                        print(result.name)
                        print(result.cast_id)
                        print(result.credit_id)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        funcDataTask?.resume()
    }
    
    private func requestTMDbActorDetails(usingUrl url: URL) {
        var funcDataTask: URLSessionTask? = defaultSession.dataTask(with: url) { [weak self] data, response, error
            in
            defer {
                print("defer -- \(url)")
                // self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let result = try JSONDecoder().decode(Actor.self, from: data)
                    print(result.birthday)
                    print(result.name)
                    print(result.popularity)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        funcDataTask?.resume()
    }
    
    private func requestTMDbMovieDetails(usingUrl url: URL) {
        var funcDataTask: URLSessionTask? = defaultSession.dataTask(with: url) { [weak self] data, response, error
            in
            defer {
                print("defer -- \(url)")
                // self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    print(result.title)
                    print(result.release_date)
                    print(result.overview)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        funcDataTask?.resume()
    }
    
    private func requestTMDbMoviesResults(usingUrl url: URL) {
//        guard dataTask == nil else {
//            print(url)
//            print(dataTask!)
//            return
//        }
        
//        dataTask?.cancel()
//        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error
        
        // Use local data task variable instead of class property -- avoids having data task being set to nil when another data task is started?
        var funcDataTask: URLSessionTask? = defaultSession.dataTask(with: url) { [weak self] data, response, error
            in
            defer {
                print("defer -- \(url)")
                // self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                    do {
                        let decodedData = try JSONDecoder().decode(MovieResponses.self, from: data)
                        let results = decodedData.results
                        for result in results {
                            print(result.title)
                            print(result.id)
                        }
                    } catch {
                         print(error.localizedDescription)
                    }
                }
            }
//        dataTask?.resume()
        funcDataTask?.resume()
    }
    
    private func requestTMDbActorsResults(usingUrl url: URL) {
//        guard dataTask == nil else {
//            print(url)
//            print(dataTask!)
//            return
//        }
//        dataTask?.cancel()
//        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error
        
        // Use local data task variable instead of class property -- avoids having data task being set to nil when another data task is started?
        var funcDataTask: URLSessionTask? = defaultSession.dataTask(with: url) { [weak self] data, response, error
            in
            defer {
                print("defer -- \(url)")
//                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let decodedData = try JSONDecoder().decode(ActorResponses.self, from: data)
                    let results = decodedData.results
                    for result in results {
                        print(result.name)
                        print(result.id)
                    }
                } catch {
                    print("Decoding failed.")
                    print(error.localizedDescription)
                }
            }
        }
//        dataTask?.resume()
        funcDataTask?.resume()
    }

    
    
}
