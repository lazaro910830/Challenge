//
//  SearchViewControllerTests.swift
//  MercadoLibreTests
//
//  Created by Lazaro Hernandez on 16/3/23.
//

import XCTest
@testable import MercadoLibre

final class SearchViewControllerTests: XCTestCase {
    var sut: SearchViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        sut = vc
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoadViewController() throws {
        let tableView = try XCTUnwrap(sut.tableView)
    }

}
