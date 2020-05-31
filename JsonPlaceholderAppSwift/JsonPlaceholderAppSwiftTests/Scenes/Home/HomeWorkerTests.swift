//
//  HomeWorkerTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class HomeWorkerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: HomeWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        setupHomeWorker()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupHomeWorker() {
        
        sut = HomeWorker()
    }
    
    // MARK: Test doubles
    class JSONPlaceholderAPISpy: JSONPlaceholderAPI {
        
        override class func getUsers(completionHandler: @escaping ([UserResponseData]?, Error?) -> Void) {
                        
            let geo = Geo(lat: "", lng: "")
            let address = Address(street: "", suite: "", city: "", zipcode: "", geo: geo)
            let userResponseData = UserResponseData(id: 1, name: "FakeName", username: "FakeSurname", email: "FakeEmail", phone: "123456789", website: "FakeWebsite", address: address)
            completionHandler([userResponseData], nil)
        }
     }
    
    // MARK: Tests
    func testGetUserList() {
        
        // When
        sut.getUserList { (responseFromWorker) in
            
            // Then
            switch responseFromWorker {
            case .success(data: let data):
                XCTAssertTrue(!(data.users?.isEmpty ?? false))
            case .failure(error: _):
                break
            }
        }
    }
}
