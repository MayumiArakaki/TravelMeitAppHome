//
//  HomeViewModelTest.swift
//  Home-Unit-UnitTests
//
//  Created by Enrique Alata Vences on 19/12/23.
//

import Foundation
import XCTest

@testable import Home

class HomeViewModelUnitTest: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testRequestList() {
        let dataSource = MonumentsMockDataSource()
        let repository = RemoteMonumentRepository(dataSource: dataSource)
        let useCase = MonumentsListingUseCase(monumentsRepository: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        
        let viewModelSpy = HomeViewModelDelegateSpy()
        viewModel.delegate = viewModelSpy
        
        viewModel.requestList()
        
        XCTAssertNotNil(viewModel.monuments)
        XCTAssertEqual(viewModelSpy.currentState, 1)
    }
}
