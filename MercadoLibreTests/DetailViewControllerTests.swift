//
//  DetailViewControllerTests.swift
//  MercadoLibreTests
//
//  Created by Lazaro Hernandez on 17/3/23.
//

import XCTest
@testable import MercadoLibre

final class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        sut = vc
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoadViewController() throws {
        let imageView = try XCTUnwrap(sut.carrouselImageView)
    }
}
