//
//  Reciplease1_1Tests.swift
//  Reciplease1.1Tests
//
//  Created by Anthony Laurent on 15/03/2022.
//

import XCTest
import Alamofire
@testable import Reciplease1_1

//class Reciplease1_1Tests: XCTestCase {
//
//
//
//    func testGetRecipeFailedCallbackIfError() {
//        // Given
//        let recipeService = RecipeService( recipeSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
//
//        // When
////        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipe(ingredients: ["lemon;cheese"]) { (success,Recipe) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertEqual(Recipe!.count, 0)
////            expectation.fulfill()
//        }
//
////        wait(for: [expectation], timeout: 0.01)
//
//    }
//
//    func testGetRecipeFailedCallbackIfNoData() {
//        // Given
//        let recipeService = RecipeService( recipeSession: URLSessionFake(data: nil, response: nil, error: nil))
//
//        // When
////        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipe(ingredients: ["lemon;cheese"]) { (success,Recipe) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(Recipe)
////            expectation.fulfill()
//        }
//
////        wait(for: [expectation], timeout: 0.01)
//
//    }
//
//    func testGetRecipeFailedCallbackIfIncorrectResponse() {
//        // Given
//        let recipeService = RecipeService( recipeSession: URLSessionFake(data: FakeResponseData.recipeCorrectData, response: FakeResponseData.responseKO, error: nil))
//
//        // When
////        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipe(ingredients: ["lemon;cheese"]) { (success,Recipe) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(Recipe)
////            expectation.fulfill()
//        }
//
////        wait(for: [expectation], timeout: 0.01)
//
//    }
//
//    func testGetRecipeFailedCallbackIfIncorrectData() {
//        // Given
//        let recipeService = RecipeService( recipeSession: URLSessionFake(data: FakeResponseData.recipeIncorrectData, response: FakeResponseData.responseOK, error: nil))
//
//        // When
////        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipe(ingredients: ["lemon;cheese"]) { (success,Recipe) in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(Recipe)
////            expectation.fulfill()
//        }
//
////        wait(for: [expectation], timeout: 0.01)
//
//    }
//
//    func testGetRecipeFailedCallbackIfNoErrorAndCorrectData() {
//        // Given
//        let recipeService = RecipeService( recipeSession: URLSessionFake(data: FakeResponseData.recipeCorrectData, response: FakeResponseData.responseOK, error: nil))
//
//        // When
////        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.getRecipe(ingredients: ["lemon;cheese"]) { (success, recipes) in
//            // Then
//
//            let recipeName = "Lemon Cake with Ricotta Cheese"
////            let recipeImageURL = ""
////            let yield = ""
////            let ingredientLines = ""
////            let totalTime = ""
////            let urlDescription = ""
//
//            XCTAssertEqual(recipes?.first?.recipeName, recipeName)
//            XCTAssertTrue(success)
//            XCTAssertNotNil(recipes)
////            expectation.fulfill()
//        }
//
////        wait(for: [expectation], timeout: 0.01)
//
//    }
//}
