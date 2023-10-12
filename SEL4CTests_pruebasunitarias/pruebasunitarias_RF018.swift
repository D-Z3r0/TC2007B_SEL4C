//
//  pruebasunitarias_RF018.swift
//  pruebasunitarias_RF018
//
//  Created by Sofía Donlucas on 05/10/23.
//

import XCTest
@testable import SEL4C

final class pruebasunitarias_RF018: XCTestCase {

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
    
    func testRF018_Estadisticas() async throws{
        let estadisticas = try await Estadisticas.fetchEstadisticasDetail(idUsuario: 1)
        XCTAssertNotNil(estadisticas)
    }
    
    func testRF018_EstadisticasInvalido() async {
        let controller = UserProgressStatusController.shared
            do {
                let statusCode = try await controller.updateProgressStatus(estadoActividad: true, estadoModulo: true, idUsuario: 2, idActividad: 1, idModulo: 4)
                // Handle the status code (e.g., check if it's 200 for OK)
                XCTAssertNotEqual(statusCode, 200)
            } catch {
                XCTFail("Error updating progress: \(error)")
            }
    }
    
    func testRF018_Evaluaciones() async throws{
        let resultadoIndividual = try await ResultadoEvaluaciones.fetchResultadoEvaluacionesDetail(idUsuario: 1)
        XCTAssertNotNil(resultadoIndividual)
    }
    
    func testRF018_EvaluacionesInvalido() async throws{
        let (statusCode, _) = try await ResultadoEvaluaciones.fetchResultadoEvaluacionesDetailStatus(idUsuario: 2)
            XCTAssertNotEqual(statusCode, 200, "Error \(statusCode).")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
