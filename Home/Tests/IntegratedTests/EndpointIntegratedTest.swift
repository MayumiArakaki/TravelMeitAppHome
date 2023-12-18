//
//  EndpointIntegratedTest.swift
//  Home
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import XCTest

@testable import Home

class testMonumentsBackendTest: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testTaskEndpointCall() {
        let exp = expectation(description: "backend is returning data")
        var success: Bool = false


        MonumentsTask.doRequest(completion: { result in
            switch result {
            case .success(let monumentsData):
                print(monumentsData)
                success = true
            case .failure(let error):
                success = false
                print(error)
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
