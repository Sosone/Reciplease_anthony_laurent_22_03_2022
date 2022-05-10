//
//  FakeResponseData.swift
//  Reciplease1.1Tests
//
//  Created by Anthony Laurent on 25/04/2022.
//

import Foundation
class FakeResponseData {
    
    static var recipeCorrectData : Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Recipe", withExtension: "json") else { return nil }
        return try? Data(contentsOf: url)
    }
    
    static let recipeIncorrectData = "erreur".data(using: .utf8)!
    
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class RecipeError: Error {}
    static let error = RecipeError()
}
