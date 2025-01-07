//
//  UnitTestingBootCampViewModel_Tests.swift
//  CoreDataBootCampTests
//
//  Created by Vincent Joy on 06/01/25.
//

// Naming structure :- test_UnitOfWork_StateUnderTest_ExpectedBehaviour = test_[struct, class or actor name]_[variable or function]_[expected result]
// Testing structure :- Given, When, Then

import XCTest
@testable import CoreDataBootCamp

final class UnitTestingBootCampViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestingBootCampViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootCampViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_UnitTestingBootCampViewModel_isPremium_isTrue() {
        // Given
        let isUserPremium: Bool = true
        
        // When
        let vm = UnitTestingBootCampViewModel(isPremium: isUserPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootCampViewModel_isPremium_isFalse() {
        // Given
        let isUserPremium: Bool = false
        
        // When
        let vm = UnitTestingBootCampViewModel(isPremium: isUserPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingBootCampViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let isUserPremium: Bool = Bool.random()
        
        // When
        let vm = UnitTestingBootCampViewModel(isPremium: isUserPremium)
        
        // Then
        XCTAssertEqual(isUserPremium, vm.isPremium)
    }
    
    func test_UnitTestingBootCampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<50 {
            // Given
            let isUserPremium: Bool = Bool.random()
            
            // When
            let vm = UnitTestingBootCampViewModel(isPremium: isUserPremium)
            
            // Then
            XCTAssertEqual(isUserPremium, vm.isPremium)
        }
    }
    
    func test_UnitTestingBootCampViewModel_dataArray_shouldBeEmpty() {
        // Given
        
        // When
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootCampViewModel_dataArray_shouldBeEmpty2() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootCampViewModel_dataArray_shouldAddItems() {
        // Given
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1...100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootCampViewModel_dataArray_shouldNotAddBlankItem() {
        // Given
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootCampViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        // When
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())

        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootCampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())

        // When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        vm.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootCampViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())

        // When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingBootCampViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingBootCampViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw item not found error") { error in
            let returnedError = error as? UnitTestingBootCampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootCampViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingBootCampViewModel_saveItem_shouldThrowError_noData() {
        // Given
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTestingBootCampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootCampViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingBootCampViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
}
