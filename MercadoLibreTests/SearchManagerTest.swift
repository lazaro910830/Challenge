//
//  SearchManagerTest.swift
//  MercadoLibreTests
//
//  Created by Lazaro Hernandez on 16/3/23.
//

import XCTest
@testable import MercadoLibre

final class SearchManagerTest: XCTestCase {
    
    var sut: SearchManager!
    var delegate: SearchManagerTestDelegate!
    var search = "https://api.mercadolibre.com/sites/MLA/search?q=Ollas"

    override func setUpWithError() throws {
        sut = SearchManager(delegate: delegate)
    }

    override func tearDownWithError() throws {
        delegate = nil
        sut = nil
    }

    func test_PerformRequest() throws {
        let expLoadingData = expectation(description: "loading")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expLoadingData.fulfill()
        }
        
        sut.performRequest(with: search)
        
        waitForExpectations(timeout: 2.0)
        
        XCTAssertTrue(sut.results.count > 0)
        
    }

}

class SearchManagerTestDelegate: SearchManagerDelegate {
    var didUpdateSearchWasCalled = false
    var loadingViewWasCalled = false
    var showErrorWasCalled = false
    var expDidUpdateSearchWasCalled: XCTestExpectation?
    
    func didUpdateSearch(_ searchrManager: MercadoLibre.SearchManager, result: [MercadoLibre.ResultModel], paging: MercadoLibre.Paging) {
        didUpdateSearchWasCalled = true
        expDidUpdateSearchWasCalled?.fulfill()
    }
    
    func loadingView(_ state: MercadoLibre.LoadingViewState) {
        loadingViewWasCalled = true
    }
    
    func showError(_ error: String, completion: (() -> Void)?) {
        showErrorWasCalled = true
    }
    
    
}
