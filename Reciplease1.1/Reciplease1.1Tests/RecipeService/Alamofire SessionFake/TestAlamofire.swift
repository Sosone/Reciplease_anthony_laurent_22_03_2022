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
    
    override func setUp() {
        <#code#>
    }
    
    override class func tearDown() {
        <#code#>
    }
    
    
    func testGetRecipe() {
        
        FakeProtocol.loadData = {
            return FakeResponseData.recipeCorrectData
        }
        
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [FakeProtocol.self] + (configuration.protocolClasses ?? [])
        let session = Alamofire.Session(configuration: configuration)
        let recipeService = RecipeService(session: session)
        
        let expectation = XCTestExpectation(description: "Waiting")
        recipeService.getRecipe(ingredients: ["duck"]) { (success,Recipe) in
            let recipes: [Recipe] = []
            XCTAssertNotNil(Recipe)
            XCTAssertTrue(success)
            XCTAssertNotNil(recipes)
            XCTAssertNotNil(recipes.count)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }   
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
