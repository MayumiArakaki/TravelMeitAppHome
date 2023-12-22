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
        
        // Verificar que se reciban datos de monumentos
        XCTAssertNotNil(viewModel.monuments)

        // Verificar que el estado actual sea el esperado
        switch viewModelSpy.currentState {
        case .success?:
            // Test exitoso si el estado es 'success'
            break
        case .loading?, .failure?:

            XCTFail("Unexpected state")
        default:
            XCTFail("No state or unexpected state")
        }
    }
}
