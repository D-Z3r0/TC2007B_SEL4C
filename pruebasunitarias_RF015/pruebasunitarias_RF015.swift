//
//  pruebasunitarias_RF015.swift
//  pruebasunitarias_RF015
//
//  Created by Sofía Donlucas on 05/10/23.
//

import XCTest
@testable import SEL4C

final class pruebasunitarias_RF015: XCTestCase {

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
    
    func testRF015_AllActivities() async throws{
        let actividades = try await Actividad.fetchActividades()
        XCTAssertNotNil(actividades)
//        XCTAssertNotNil(questions)
    }
    
    func testRF015_AllActivitiesInvalido() async throws {
        let actividades = try await Actividad.fetchActividades()
        
        if actividades.isEmpty {
            XCTAssertFalse(false, "El arreglo de actividades está vacío")
        }
    }
    
    func testRF015_ActivitiesDetail() async throws{
        let actividades = try await Actividad.fetchActividades()
        for act in actividades{
            let actividad = try await Actividad.fetchActividadesDetail(id_actividad: act.id_actividad)
            XCTAssertNotNil(actividad)
        }
//        XCTAssertNotNil(questions)
    }
    
    func testRF015_ActivitiesDetailInvaldo() async throws {
        let (statusCode, actividad) = try await Actividad.fetchActividadesDetailStatus(id_actividad: 5)

        if statusCode == 200 {
            XCTAssertNotNil(actividad, "Actividad cargada con éxito pero sin modulo valido")
        } else {
            XCTAssertNil(actividad, "Actividad cargada sin éxito")
        }
    }
    
    func testRF015_AllModules() async throws{
        let actividades = try await Actividad.fetchActividades()
        for actividad in actividades{
            let modulos = try await Modulo.fetchModulos(id_actividad: actividad.id_actividad)
            XCTAssertNotNil(modulos)
        }
//        XCTAssertNotNil(questions)
    }
    
    func testRF015_AllModulesInvalido() async throws{
        let actividades = try await Actividad.fetchActividades()
        for actividad in actividades{
            let modulos = try await Modulo.fetchModulos(id_actividad: actividad.id_actividad)
            if modulos.isEmpty {
                XCTAssertFalse(false, "El arreglo de modulos está vacío")
            }
        }
//        XCTAssertNotNil(questions)
    }
    
    func testRF015_ModulesDetail() async throws{
        let actividades = try await Actividad.fetchActividades()
        for actividad in actividades{
            let modulos = try await Modulo.fetchModulos(id_actividad: actividad.id_actividad)
            for mod in modulos{
                let modulo = try await Modulo.fetchModulosDetail(id_actividad: actividad.id_actividad, id_modulo: mod.id_modulo)
                XCTAssertNotNil(modulo)
            }
        }
//        XCTAssertNotNil(questions)
    }
    
    func testRF015_ModulesDetailInvalido() async throws{
        let (statusCode, actividad) = try await Modulo.fetchModulosDetailStatus(id_actividad: 5, id_modulo: 5)

            if statusCode == 200 {
                XCTAssertNotNil(actividad, "Actividad cargada sin modulo valido")
            } else {
                XCTAssertNil(actividad, "Actividad cargada con modulo nulo")
            }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
