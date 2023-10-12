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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRF012_Login() async throws {
        user.email = "test@test.com"
        user.contrasena = "Test12345"
        let loginController = LoginController()
        let loginUser = try await loginController.userLogin(loginResponse: user)
        let httpResponseCode = loginUser?["statusCode"] as? Int
        XCTAssertEqual(httpResponseCode, 200, "La petición POST no debería devolver un código de estado 201")
//        if let httpResponseCode = loginUser?["statusCode"] as? Int {
//            XCTAssertEqual(httpResponseCode, 200, "La petición POST no debería devolver un código de estado 201")
//        } else {
//            XCTFail("La respuesta del servidor no contiene un código de estado")
//        }
}
    
    func testRF012_InvalidLogin() async throws {
//        invalidUser.username = "test"
        invalidUser.email = "test@test.com"
        invalidUser.contrasena = "Test12345"
//        invalidUser.photo = nil
//        invalidUser.grado_ac = "Pregrado (licenciatura, profesional, universidad, grado)"
//        invalidUser.institucion = "Tec de Monterrey"
//        invalidUser.genero = "Prefiero no decir"
//        invalidUser.edad = 21
//        invalidUser.pais = "Mexico"
        let loginController = LoginController()
        let loginUser = try await loginController.userLogin(loginResponse: invalidUser)
        let httpResponseCode = loginUser?["statusCode"] as? Int
        XCTAssertNotEqual(httpResponseCode, 200, "La petición POST no debería devolver un código de estado 201")
//        if let httpResponseCode = loginUser?["statusCode"] as? Int {
//            XCTAssertNotEqual(httpResponseCode, 200, "La petición POST no debería devolver un código de estado 201")
//        } else {
//            XCTFail("La respuesta del servidor no contiene un código de estado")
//        }
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
