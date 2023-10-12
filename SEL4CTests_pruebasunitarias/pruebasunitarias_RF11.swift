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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRF011_Singup() async throws {
        user.username = "test"
        user.email = "test@test.com"
        user.contrasena = "Test12345"
        user.photo = nil
        user.grado_ac = "Pregrado (licenciatura, profesional, universidad, grado)"
        user.institucion = "Tec de Monterrey"
        user.genero = "Prefiero no decir"
        user.edad = 21
        user.pais = "Mexico"
        let signupController = SignupController()
        let createUser = try await signupController.userSignup(signupResponse: user)
        let httpResponseCode = createUser?["statusCode"] as? Int
        XCTAssertEqual(httpResponseCode, 201, "La petición POST no debería devolver un código de estado 201")
//        if let httpResponseCode = createUser?["statusCode"] as? Int {
//            XCTAssertEqual(httpResponseCode, 201, "La petición POST debería devolver un código de estado 201")
//        } else {
//            XCTFail("La respuesta del servidor no contiene un código de estado")
//        }
    }
    
    func testRF011_SingupInvalid() async throws {
//        invalidUser.username = "test"
        invalidUser.email = "test@test.com"
        invalidUser.contrasena = "Test12345"
        invalidUser.photo = nil
        invalidUser.grado_ac = "Pregrado (licenciatura, profesional, universidad, grado)"
        invalidUser.institucion = "Tec de Monterrey"
        invalidUser.genero = "Prefiero no decir"
        invalidUser.edad = 21
        invalidUser.pais = "Mexico"
        let signupController = SignupController()
        let createUser = try await signupController.userSignup(signupResponse: invalidUser)
        let httpResponseCode = createUser?["statusCode"] as? Int
        XCTAssertNotEqual(httpResponseCode, 201, "La petición POST no debería devolver un código de estado 201")
//        if let httpResponseCode = createUser?["statusCode"] as? Int {
//            XCTAssertNotEqual(httpResponseCode, 201, "La petición POST no debería devolver un código de estado 201")
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
