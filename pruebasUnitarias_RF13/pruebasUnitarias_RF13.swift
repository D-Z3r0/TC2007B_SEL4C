//
//  pruebasUnitarias_RF13.swift
//  pruebasUnitarias_RF13
//
//  Created by Daniel Rong Chen on 11/10/23.
//

import XCTest
@testable import SEL4C

final class pruebasUnitarias_RF13: XCTestCase {
    var user = Users()
    var invalidUser = Users()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRF011_UpdateUser() async throws {
        user.id_usuario = 1
        user.username = "test"
        user.email = "test@test.com"
        user.contrasena = "Test12345"
        user.photo = nil
        user.grado_ac = "Pregrado (licenciatura, profesional, universidad, grado)"
        user.institucion = "Tec de Monterrey"
        user.genero = "Prefiero no decir"
        user.edad = 21
        user.pais = "Mexico"
        do {
            try await Users.putUser(user: user)
            let httpResponseCode = 200
            XCTAssertEqual(httpResponseCode, 200, "La petición PUT debería devolver un código de estado 200")
        } catch {
            XCTFail("La petición PUT falló con el error: \(error)")
        }
    }
    
    func testRF011_UpdateUserInvalid() async throws {
        invalidUser.id_usuario = 1
        invalidUser.username = "test"
        invalidUser.email = "test@test.com"
        invalidUser.contrasena = "Test12345"
        invalidUser.photo = nil
        invalidUser.grado_ac = "Pregrado (licenciatura, profesional, universidad, grado)"
        invalidUser.institucion = "Tec de Monterrey"
        invalidUser.genero = "Prefiero no decir"
        user.pais = "Mexico"
        do {
            try await Users.putUser(user: user)
        } catch {
            if let getUserError = error as? GetUserError, getUserError == .itemNotFound {
                // La solicitud PUT no tuvo éxito, el código de estado no es 200
                XCTFail("La petición PUT no debería devolver un código de estado 200")
            } else {
                XCTFail("Error inesperado: \(error)")
            }
        }
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
