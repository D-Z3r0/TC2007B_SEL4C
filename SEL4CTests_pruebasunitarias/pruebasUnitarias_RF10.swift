//
//  pruebasUnitarias_RF10.swift
//  pruebasUnitarias_RF10
//
//  Created by Daniel Rong Chen on 10/10/23.
//

import XCTest
@testable import SEL4C

final class pruebasUnitarias_RF10: XCTestCase {
    var user = UserLogin()
    var invalidUser = UserLogin()
    
    func testRF012_Login() async throws {
        user.email = "july@gmail.com"
        user.contrasena = "Gatito10"
        let loginController = LoginController()
        let loginUser = try await loginController.userLogin(loginResponse: user)
        XCTAssertNotNil(loginUser)
//        if let httpResponseCode = loginUser?["statusCode"] as? Int {
//            XCTAssertEqual(httpResponseCode, 200, "La petición POST no debería devolver un código de estado 201")
//        } else {
//            XCTFail("La respuesta del servidor no contiene un código de estado")
//        }
}
    var loginController: LoginController!

        override func setUpWithError() throws {
            super.setUp()
            loginController = LoginController()
        }

        override func tearDownWithError() throws {
            loginController = nil
            super.tearDown()
        }
    
    func testRF012_InvalidLogin() async throws {
        user.email = "july@gmail.com"
        let loginResponse = UserLogin(/* fill with data that would trigger a non-200 response */)

            let (response, statusCode) = try await loginController.userLoginStatus(loginResponse: loginResponse)

            XCTAssertNil(response, "Expected the response to be nil.")
            XCTAssertNotEqual(statusCode, 200, "Expected a non-200 status code, but got 200.")
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
