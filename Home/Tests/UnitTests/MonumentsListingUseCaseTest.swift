//
//  MonumentsListeningUseCaseTest.swift
//  Home-Unit-UnitTests
//
//  Created by Enrique Alata Vences on 19/12/23.
//

import Foundation
import XCTest

@testable import Home

class MonumentsListingUseCaseyUnitTest: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testExecuteListing() {
        let exp = expectation(description: "the use case calls the repository")
        var success: Bool = false
        
        let dataSource = MonumentsMockDataSource()
        let repository = RemoteMonumentRepository(dataSource: dataSource)
        let useCase = MonumentsListingUseCase(monumentsRepository: repository)
        
        useCase.execute(completion: { result in
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
