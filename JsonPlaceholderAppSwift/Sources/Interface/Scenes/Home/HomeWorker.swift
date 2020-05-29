//
//  HomeWorker.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

enum JSONPlaceholderAPIUserResult {
    
    case success(data: UserConfiguration)
    case failure(error: Error)
}

typealias HomeWorkerCompletionHandler = (_ data: JSONPlaceholderAPIUserResult) -> Void

class HomeWorker {
    
    func getUserList(result: @escaping HomeWorkerCompletionHandler) {
        
        JSONPlaceholderAPI.getUsers { (userResponseData, error) in
            
            if let error = error {
                
                result(JSONPlaceholderAPIUserResult.failure(error: error))
            } else if let userResponseData = userResponseData {
                
                var users = [ChoosenUser]()
                for singleUser in userResponseData {
                    
                    users.append(ChoosenUser(id: singleUser.id, name: singleUser.username, surname: singleUser.name, phone: singleUser.phone))
                }
                result(JSONPlaceholderAPIUserResult.success(data: UserConfiguration(users: users)))
            }
        }
    }
}
