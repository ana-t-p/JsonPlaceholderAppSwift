//
//  SelectedUserWorkerTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class SelectedUserWorkerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: SelectedUserWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        setupSelectedUserWorker()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupSelectedUserWorker() {
        
        sut = SelectedUserWorker()
    }
    
    // MARK: Tests
    func testGetUserList() {
        
        // When
        sut.getSelectedUserDetails(1) { (photo, posts, todos, error) in
            
            XCTAssertNotNil(photo)
            XCTAssertNotNil(posts)
            XCTAssertNotNil(todos)
            XCTAssertTrue(error.isEmpty)
        }
        waitUI()
    }
}
