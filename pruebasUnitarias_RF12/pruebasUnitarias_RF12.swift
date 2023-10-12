//
//  pruebasUnitarias_RF12.swift
//  pruebasUnitarias_RF12
//
//  Created by Daniel Rong Chen on 11/10/23.
//

import XCTest
@testable import SEL4C

final class pruebasUnitarias_RF12: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRF012_GetUser() async throws {
        let getUser = try await Users.getUser()
        XCTAssertNotNil(getUser.username)
    }
    
    func testRF012_GetUserInvalid() async throws {
        let getUser = try await Users.getUser()
        XCTAssertNil(getUser)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
