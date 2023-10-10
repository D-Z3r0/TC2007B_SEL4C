//
//  pruebasunitarias_RF021.swift
//  pruebasunitarias_RF021
//
//  Created by Sofía Donlucas on 05/10/23.
//

import XCTest
@testable import SEL4C

final class pruebasunitarias_RF021: XCTestCase {
    
    func testSendEvidenceImage() async throws {
        let user = "Usuario de prueba"
        let activity = "Actividad de prueba"
        let evidenceName = "Evidencia de prueba"
        let idModulo = 1
        let image = UIImage(named: "1 - Inicio")!
        let response = try await MultipartRequest.sendEvidenceTest(user: user, activity: activity, evidence_name: evidenceName, idModulo: idModulo, imagen: image)
        XCTAssertEqual(response, 201)
    }
    
    func testSendEvidenceImageInvalido() async throws {
        let user = "Usuario de prueba"
        let activity = "Actividad de prueba"
        let evidenceName = "Evidencia de prueba"
        let idModulo = 1
        let image = UIImage(named: "1 - Inicio")!
        let response = try await MultipartRequest.sendEvidenceTest(user: user, activity: activity, evidence_name: evidenceName, idModulo: idModulo, imagen: image)
        XCTAssertNotEqual(response, 201)
    }
    
    func testSendEvidenceVideo() async throws {
        let audioData = NSDataAsset(name: "video_prueba")?.data
        XCTAssertNotNil(audioData)
        let user = "Usuario de prueba"
        let activity = "Actividad de prueba"
        let evidenceName = "Evidencia de prueba"
        let idModulo = 4
        let videoPath = "Users/sofiadonlucas/Desktop/TC2007B_SEL4C/SEL4C/Assets.xcassets/video_prueba.dataset/banana.mp4"
        
        let response = try await MultipartRequestVideo.sendEvidenceTestVideo(user: user, activity: activity, evidenceName: evidenceName, idModulo: idModulo, videoPath: videoPath)
        XCTAssertEqual(response, 201)
    }
    
    func testSendEvidenceVideoInvalido() async throws {
        let audioData = NSDataAsset(name: "video_prueba")?.data
        XCTAssertNotNil(audioData)
        let user = "Usuario de prueba"
        let activity = "Actividad de prueba"
        let evidenceName = "Evidencia de prueba"
        let idModulo = 4
        let videoPath = "Users/sofiadonlucas/Desktop/TC2007B_SEL4C/SEL4C/Assets.xcassets/video_prueba.dataset/banana.mp4"
        
        let response = try await MultipartRequestVideo.sendEvidenceTestVideo(user: user, activity: activity, evidenceName: evidenceName, idModulo: idModulo, videoPath: videoPath)
        XCTAssertNotEqual(response, 201)
    }
    
    func testSendEvidenceAudio() async throws {
        let user = "Usuario de prueba"
        let activity = "Actividad de prueba"
        let evidenceName = "Evidencia de prueba"
        let idModulo = 2

        if let audioData = NSDataAsset(name: "audio_prueba")?.data {
            let response = try await MultipartRequestAudio.sendAudioEvidenceTest(user: user, activity: activity, evidenceName: evidenceName, idModulo: idModulo, audioData: audioData)
            XCTAssertEqual(response, 201)
        } else {
            XCTFail("No se pudo cargar el archivo de audio desde los assets.")
        }
    }
    
    func testSendEvidenceAudioInvalido() async throws {
        let user = "Usuario de prueba"
        let activity = "Actividad de prueba"
        let evidenceName = "Evidencia de prueba"
        let idModulo = 2

        if let audioData = NSDataAsset(name: "audio_prueba")?.data {
            let response = try await MultipartRequestAudio.sendAudioEvidenceTest(user: user, activity: activity, evidenceName: evidenceName, idModulo: idModulo, audioData: audioData)
            XCTAssertNotEqual(response, 201)
        } else {
            XCTFail("No se pudo cargar el archivo de audio desde los assets.")
        }
    }

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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
