//
//  TMDbAccess.swift
//  TMDbTest2
//
//  Created by Michael Evans on 7/18/20.
//  Copyright © 2020 MREink. All rights reserved.
//

import Foundation

class TMDbAccess {
    
    struct NameValueItem {
        let name: String
        let value: String
    }
    
    func getUrlFrom(_ urlString: String, nameValueItems: [NameValueItem]) -> URL? {
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        
        var urlItems = [URLQueryItem]()
        
        for nameValueItem in nameValueItems {
            let urlQueryItem = URLQueryItem(name: nameValueItem.name, value: nameValueItem.value)
            urlItems.append(urlQueryItem)
        }
        
        urlComponents.queryItems = urlItems
        
        return urlComponents.url
        
    }
    
}
