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
    func test() {
        let expectation = expectation(description: "Wait")
        RecipeService.shared.getRecipe(ingredients: ["duck"]) { (success, Recipe) in
            let recipes: [Recipe] = []
            XCTAssertNotNil(recipes.count)
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
//    func testGetRecipe() {
//
//        FakeProtocol.loadData = {
//            return FakeResponseData.recipeCorrectData
//        }
//
//        let configuration = URLSessionConfiguration.af.ephemeral
//        configuration.protocolClasses = [FakeProtocol.self] + (configuration.protocolClasses ?? [])
//        let session = Alamofire.Session(configuration: configuration)
//        let recipeService = RecipeService(session: session)
//
//        let expectation = expectation(description: "Wait")
//        recipeService.getRecipe(ingredients: ["duck"]) { (success,Recipe) in
//            let recipes: [Recipe] = []
//            XCTAssertTrue(success)
//            XCTAssertNotNil(recipes.count)
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 10, handler: nil)
//
//
//        }
    }


class FakeProtocol: URLProtocol
{
    static var loadData: () -> Data? = { return nil }
    static var loadError: () -> Error? = { return nil }
    
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
