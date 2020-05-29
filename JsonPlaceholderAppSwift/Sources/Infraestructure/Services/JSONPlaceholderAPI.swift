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
                
                guard let decodedResponse = decodeJSONDictionaryUsersResponseValues(data) else {
                    
                    return completionHandler(nil, ErrorCases.decoding)
                }
                completionHandler(decodedResponse, nil)
            } else if let error = error {
                
                completionHandler(nil, error)
            }
        }.resume()
    }
    
    // MARK: User information
    class func getUserPosts(_ id: Int, completionHandler: @escaping ([PostResponseData]?, Error?) -> Void) {
        
        guard let url = URL(string: Constants.Urls.jsonPHUrl + Constants.Urls.posts + "\(id)") else {
            
            completionHandler(nil, ErrorCases.usedURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                
                guard let decodedResponse = decodeJSONDictionaryPostsResponseValues(data) else {
                    
                    return completionHandler(nil, ErrorCases.decoding)
                }
                completionHandler(decodedResponse, nil)
            } else if let error = error {
                
                completionHandler(nil, error)
            }
        }.resume()
    }
    
    class func getUserTODOList() {
        
        
    }
    
    class func getUserImage() {
        
        
    }
    
    // MARK: Private
    private class func decodeJSONDictionaryUsersResponseValues(_ data: Data) -> [UserResponseData]? {
        
        var usersResponseData: [UserResponseData]?
        do {

            usersResponseData = try JSONDecoder().decode([UserResponseData].self, from: data)
        } catch {
            
            print("Error: \(error.localizedDescription)\n")
        }
        return usersResponseData
    }
    
    private class func decodeJSONDictionaryPostsResponseValues(_ data: Data) -> [PostResponseData]? {
        
        var postsResponseData: [PostResponseData]?
        do {

            postsResponseData = try JSONDecoder().decode([PostResponseData].self, from: data)
        } catch {
            
            print("Error: \(error.localizedDescription)\n")
        }
        return postsResponseData
    }
}
