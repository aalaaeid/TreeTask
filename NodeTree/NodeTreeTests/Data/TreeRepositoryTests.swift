//
//  TreeRepositoryTests.swift
//  NodeTreeTests
//
//  Created by Alaa Eid on 09/02/2024.
//

import XCTest
@testable import NodeTree

final class TreeRepositoryTests: XCTestCase {

    var sut: RemoteTreeRepository!
    var apiProider: MockAPIProvider!
    override func setUp() {
        apiProider = MockAPIProvider()
        sut = RemoteTreeRepository(apiProvider: apiProider)
        super.setUp()
    }
    
    override func tearDown() {
        apiProider = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchTree_Remote() {
        //Given
        apiProider.mockPath = URLRequestBuilderMocking.getRoot.path
        
        //When
        _  = sut.fetchTree().sink(receiveCompletion: { _ in }, receiveValue: { trees in
            //Then
            XCTAssertNotNil(trees)
        })
    
    }

}

