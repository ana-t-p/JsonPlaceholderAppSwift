//
//  LocalizedErrorExtensionTests.swift
//  JsonPlaceholderAppSwiftTests
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import XCTest
@testable import JsonPlaceholderAppSwift

class LocalizedErrorExtensionTests: XCTestCase {

    func testErrorCases() {
        
        XCTAssertEqual(ErrorCases.usedURL.localizedDescription, "error.usedURL".localized)
        XCTAssertEqual(ErrorCases.apiCalling.localizedDescription, "error.apiCalling".localized)
        XCTAssertEqual(ErrorCases.decoding.localizedDescription, "error.decoding".localized)
        XCTAssertEqual(ErrorCases.userNotFound.localizedDescription, "error.userNotFound".localized)
        XCTAssertEqual(ErrorCases.unknown.localizedDescription, "error.unknown".localized)
    }
}
