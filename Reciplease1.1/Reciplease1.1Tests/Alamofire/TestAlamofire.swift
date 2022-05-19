//
//  TestAlamofire.swift
//  Reciplease1.1Tests
//
//  Created by Anthony Laurent on 03/05/2022.
//
import Alamofire
import XCTest
@testable import Reciplease1_1

class TestAlamofire: XCTestCase {
    
//    override func setUp() {
//        <#code#>
//    }
//
//    override class func tearDown() {
//        <#code#>
//    }
    
    let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [FakeProtocol.self] + (configuration.protocolClasses ?? [])
        return Alamofire.Session(configuration: configuration)
    }()
    
    
    func testGetRecipe() {

        FakeProtocol.loadData = {
            return FakeResponseData.recipeCorrectData
        }

        let recipeService = RecipeService(session: session, imageLoader: { _ in return Data() })

        let expectation = expectation(description: "wait")
        recipeService.getRecipe(ingredients: ["duck"]) { (success, recipes) in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipes)
            XCTAssertNotEqual(recipes!.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testCannotGetRecipe()
    {
        FakeProtocol.loadData = {
            return FakeResponseData.recipeIncorrectData
        }

        let recipeService = RecipeService(session: session, imageLoader: { _ in return Data() })

        let expectation = expectation(description: "wait")
        recipeService.getRecipe(ingredients: ["duck"]) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testCannotCreateURLWhenIngredientHasInvalidCharacter()
    {
        FakeProtocol.loadData = {
            return FakeResponseData.recipeCorrectData
        }

        let recipeService = RecipeService(session: session, imageLoader: { _ in return Data() })

        let expectation = expectation(description: "wait")
        let utf16String = String(bytes: [0xD8, 0x00] as [UInt8], encoding: .utf16BigEndian)!
        recipeService.getRecipe(ingredients: [utf16String]) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
    
    class FakeProtocol: URLProtocol {
        
        static var loadData: () -> Data? = { return nil }
        static var loadError: () -> Error? = { return nil }
        static var loadResponse: () -> URLResponse? = { return nil }
        
        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {

            if let data = Self.loadData()
            {
                client?.urlProtocol(self, didReceive: HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)

            }
            else if let error = Self.loadError()
            {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
        
        
        override func stopLoading() {
            
        }
}
