//
//  JSONPlaceholderAPI.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import Foundation

class JSONPlaceholderAPI {
    
    // MARK: Users
    class func getUsers(completionHandler: @escaping ([UserResponseData]?, Error?) -> Void) {
        
        guard let url = URL(string: Constants.Urls.jsonPHUrl + Constants.Urls.users) else {
            
            completionHandler(nil, ErrorCases.usedURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                
                guard let decodedResponse = decodeJSONDictionaryResponseValues(data) else {
                    
                    return completionHandler(nil, ErrorCases.decoding)
                }
                completionHandler(decodedResponse, nil)
            } else if let error = error {
                
                completionHandler(nil, error)
            }
        }.resume()
    }
    
    // MARK: User information
    class func getUserPosts() {
        
        
    }
    
    class func getUserTODOList() {
        
        
    }
    
    class func getUserImage() {
        
        
    }
    
    // MARK: Private
    private class func decodeJSONDictionaryResponseValues(_ data: Data) -> [UserResponseData]? {
        
        var userResponseData: [UserResponseData]?
        do {

            userResponseData = try JSONDecoder().decode([UserResponseData].self, from: data)
        } catch {
            
            print("Error: \(error.localizedDescription)\n")
        }
        return userResponseData
    }
}
