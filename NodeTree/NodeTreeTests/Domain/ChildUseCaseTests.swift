//
//  ChildUseCaseTests.swift
//  NodeTreeTests
//
//  Created by Alaa Eid on 02/02/2024.
//

import XCTest
import Combine
@testable import NodeTree

final class ChildUseCaseTests: XCTestCase {

    var sut: ChildUseCase!
    var remoteTreeRepository: MockRemoteTreeRepository!
    
    override func setUp() {
        
        remoteTreeRepository = MockRemoteTreeRepository()
        sut = ChildUseCase(treeRepo: remoteTreeRepository)
        super.setUp()
    }
    
    override func tearDown() {
        
        sut = nil
        remoteTreeRepository = nil
        super.tearDown()
    }

    func test_fetchChildsCallRemoteRepoistory() {
        //Given
       let expectation = XCTestExpectation(description: "fetch Childs Called")
        
        //When
       _ = sut.fetchChilds(treeID: "").sink { _ in
            expectation.fulfill()
        } receiveValue: { _ in }

        
        //Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(remoteTreeRepository.fetchChildsCalled)
    }
}
