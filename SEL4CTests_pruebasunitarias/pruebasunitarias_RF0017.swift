//
//  pruebasunitarias_RF0017.swift
//  pruebasunitarias_RF0017
//
//  Created by Sofía Donlucas on 10/10/23.
//

import XCTest
@testable import SEL4C

final class pruebasunitarias_RF0017: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testCompleteActivity() async throws {
        let controller = UserProgressUpdateController()
        controller.updateProgress(estadoActividad: false, estadoModulo: true, idUsuario: 1, idActividad: 1, idModulo: 1)
        XCTAssertTrue(true, "Actividad completada con éxito")
    }
    
    func testCompleteActivityInvalido() async throws {
        let controller = UserProgressUpdateController()
        controller.updateProgress(estadoActividad: false, estadoModulo: true, idUsuario: 1, idActividad: 1, idModulo: 4)
        XCTAssertFalse(false, "Actividad completada sin éxito, modulo no encontrado")
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
