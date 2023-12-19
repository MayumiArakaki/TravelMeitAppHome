//
//  DataSourceTest.swift
//  Home-Unit-IntegratedTest
//
//  Created by Enrique Alata Vences on 17/12/23.
//

import Foundation
import XCTest

@testable import Home

class MonumentsDataSourceTest: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testDatasourceListing() {
        let exp = expectation(description: "backend is returning data")
        var success: Bool = false
        
        let dataSource = MonumentsRemoteDataSource()
        
        dataSource.list(completion: { result in
            switch result {
            case .success(let monumentResponseDTO):
                print(monumentResponseDTO)
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
