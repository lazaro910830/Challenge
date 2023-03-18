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
    var search = "https://api.mercadolibre.com/sites/MLA/search?q=Ollas"

    override func setUpWithError() throws {
        sut = SearchManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_PerformRequest() throws {
        let expLoadingData = expectation(description: "loading")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expLoadingData.fulfill()
        }
        
        sut.performRequest(with: search)
        
        waitForExpectations(timeout: 2.0)
        
        XCTAssertTrue(sut.results.count > 0)
        
    }

}
