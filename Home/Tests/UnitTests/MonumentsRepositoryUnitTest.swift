//
//  MonumentsRepositoryUnitTest.swift
//  Home
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import Foundation
import XCTest

@testable import Home

class MonumentsRepositoryUnitTest: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testRepositoryListing() {
        let exp = expectation(description: "backend is returning data and we can obtain domain entities")
        var success: Bool = false
        
        let dataSource = MonumentsMockDataSource()
        let repository = RemoteMonumentRepository(dataSource: dataSource)
        
        repository.performListRequest(completion: { result in
            switch result {
            case .success(let domainMonumentsArray):
                print(domainMonumentsArray)
                success = true
            case .failure(let error):
                print(error)
                success = false
            }
            exp.fulfill()
        })

        waitForExpectations(timeout: 30) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(success, true)
        }
    }
}
