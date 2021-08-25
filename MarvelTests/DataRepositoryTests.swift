//
//  DataRepositoryTests.swift
//  MarvelTests
//
//  Created by Margaret López Calderón on 5/8/21.
//

import XCTest
@testable import Marvel

class DataRepositoryTests: XCTestCase {
    private var sut = DataRepository(dataSource: NetworkingDataSource())

    func test_getAllCharacters_shouldBe_success() {
        do {
            let response = try sut.getAllCharacters(offset: 0)
            XCTAssertFalse(response.characters.isEmpty , "This test failure because the response doesn't have characters")
        } catch let error {
            XCTFail("Throw error: \(error)")
        }
    }
    
    func test_search_character_name_start_shouldBe_success() {
        do {
            let response = try sut.getCharacter(GellAllCharactersInput(nameStartsWith: "alpha"))
            XCTAssertFalse(response.characters.isEmpty , "This test failure because the response doesn't have any result")
        } catch let error {
            XCTFail("Throw error: \(error)")
        }
    }
}
