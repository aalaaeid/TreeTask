//
//  TreeViewModelTests.swift
//  NodeTreeTests
//
//  Created by Alaa Eid on 09/02/2024.
//

import XCTest
import Combine
@testable import NodeTree

final class TreeViewModelTests: XCTestCase {

    var sut: TreeVC.ViewModel!
    var treeUseCase: MockTreeUseCase!
    var childUseCase: MockChildUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        
        treeUseCase = MockTreeUseCase()
        childUseCase = MockChildUseCase()
        sut = TreeVC.ViewModel(treeUseCase: treeUseCase, childUseCase: childUseCase)
        cancellables = []
        super.setUp()
    }
    
    override func tearDown() {
        treeUseCase = nil
        childUseCase = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_fetchRootSuccess() {
        //Given
        let expectedRoot: [Tree] = [Tree(structDesc: "", childnodecount: 1, structID: "")]
        let expectation = XCTestExpectation(description: "Fetch Root Success")
        treeUseCase.fetchTreeResult = Result.Publisher(expectedRoot).eraseToAnyPublisher()
        //When
        sut.fetchRoot()
        
        //Then
        sut.fetchTreeSuccess.sink { trees in
            XCTAssertEqual(trees, expectedRoot)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }


    
}



