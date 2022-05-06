//
//  AlamofireSessionFake.swift
//  Reciplease1.1Tests
//
//  Created by Anthony Laurent on 02/05/2022.
//

//import Foundation
//import Alamofire
//@testable import Reciplease1_1
//
//public class Request {
//
//    var request:String?
//    struct response{
//        static var data:HTTPURLResponse?
//        static var json:AnyObject?
//        static var error:NSError?
//    }
//
//    init (request:String){
//        self.request = request
//    }
//
//    public func responseJSON(options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: (NSURLRequest, HTTPURLResponse?, AnyObject?, NSError?) -> Void) -> Self {
//
//        completionHandler(NSURLRequest(url: NSURL(string:self.request!)! as URL), Request.response.data, Request.response.json, Request.response.error)
//        return self
//    }
//}
