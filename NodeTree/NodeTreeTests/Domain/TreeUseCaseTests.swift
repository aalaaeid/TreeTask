//
//  TreeUseCaseTests.swift
//  NodeTreeTests
//
//  Created by Alaa Eid on 02/02/2024.
//

import XCTest
import Combine
@testable import NodeTree


final class TreeUseCaseTests: XCTestCase {

    var sut: TreeUseCase!
    var remoteTreeRepoistory: MockRemoteTreeRepository!

    override func setUp() {
        remoteTreeRepoistory = MockRemoteTreeRepository()
        sut = TreeUseCase(treeRepo: remoteTreeRepoistory!)
        super.setUp()
    }
    
    override func tearDown() {
        
        sut = nil
        remoteTreeRepoistory = nil
        super.tearDown()
    }
    
    func testFetchTree_CallsFetchTreeInRepository(){
        // Given
        let expectation = XCTestExpectation(description: "Fetch tree called")
              
        // When
           _ = sut.fetchTree().sink(receiveCompletion: { _ in
               expectation.fulfill()
           }, receiveValue: { _ in })
        
        // Then
           wait(for: [expectation], timeout: 1.0)
           XCTAssertTrue(remoteTreeRepoistory.fetchTreeCalled)
    }
}



