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
