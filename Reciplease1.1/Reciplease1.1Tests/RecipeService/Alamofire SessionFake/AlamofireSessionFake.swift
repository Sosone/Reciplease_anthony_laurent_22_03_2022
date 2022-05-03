//
//  AlamofireSessionFake.swift
//  Reciplease1.1Tests
//
//  Created by Anthony Laurent on 02/05/2022.
//

import Foundation
import Alamofire
@testable import Reciplease1_1

class AlamofireSessionFake {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(url: URL) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
    }
}
