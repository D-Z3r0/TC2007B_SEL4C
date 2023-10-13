//
//  pruebasunitarias_RF11.swift
//  pruebasunitarias_RF11
//
//  Created by Daniel Rong Chen on 10/10/23.
//

import XCTest
@testable import SEL4C

final class pruebasunitarias_RF11: XCTestCase {
    var user = Users()
    var invalidUser = Users()

    var signupController: SignupController!
    override func setUpWithError() throws {
            super.setUp()
            signupController = SignupController()
        }

        override func tearDownWithError() throws {
            signupController = nil
            super.tearDown()
        }
    
    func testRF011_Singup() async throws {
        user.username = "test"
        user.email = "test@test.com"
        user.contrasena = "Test12345"
        user.photo = nil
        user.grado_ac = "licenciatura"
        user.institucion = "Tec de Monterrey"
        user.genero = "Prefiero no decir"
        user.edad = 21
        user.pais = "Mexico"
        let signupController = SignupController()
        let (response, statusCode) = try await signupController.userSignupStatus(signupResponse: user)

                XCTAssertNotNil(response, "Expected a valid JSON response, but got nil.")
                XCTAssertEqual(statusCode, 201, "Expected a 201 status code, but got \(statusCode).")
    }
    
    func testRF011_SingupInvalid() async throws {
            invalidUser.email = "testtest.com"
            // ... (other invalidUser properties)

            let (response, statusCode) = try await signupController.userSignupStatus(signupResponse: invalidUser)

            XCTAssertNotEqual(statusCode, 201, "Expected a non-201 status code, but got 201.")
        }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
}
