////
////  APIProtocol.swift
////  NetworkExample
////
////  Created by Tyler Thompson on 3/28/20.
////  Copyright © 2020 World Wide Technology. All rights reserved..
////
//
//import Foundation
//import Combine
//
//protocol RESTAPIProtocol {
//    typealias RequestModifier = ((URLRequest) -> URLRequest)
//
//    var baseURL: String { get }
//    var urlSession: URLSession { get }
//}
//
//extension RESTAPIProtocol {
//    var baseURL: String {
//        "https://test.ryets.com/v2/"
//    }
//    
//    var vinAuditURL: String {
//        "https://api.vinaudit.com/"
//    }
//}
//
//extension RESTAPIProtocol {
//    var urlSession: URLSession {
//        let configuration = URLSessionConfiguration.ephemeral
//        let session = URLSession(configuration: configuration)
//        return session
//    }
//
//    func get(endpoint: String, url: String,
//             queryItems: [URLQueryItem] = [],
//             requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
//
//        guard let url = URL(string: url), var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return Fail(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()}
//        components.path = "/test/" + endpoint
//        components.queryItems = queryItems
//        components.scheme = "https"
//        guard let requestUrl = components.url else {
//            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.wrongURLQuery(queryItems: queryItems))
//                .eraseToAnyPublisher() }
//
//        let request = URLRequest(url: requestUrl)
//        return createPublisher(for: request, requestModifier: requestModifier)
//        
//        
//    }
//
//    func put(endpoint: String, body: Data?, requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
//        guard let url = URL(string: "\(baseURL)")?.appendingPathComponent(endpoint) else {
//            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.httpBody = body
//        return createPublisher(for: request, requestModifier: requestModifier)
//    }
//
//    func post(endpoint: String, body: Data?, requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
//        guard let url = URL(string: "\(baseURL)")?.appendingPathComponent(endpoint) else {
//            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = body
//        return createPublisher(for: request, requestModifier: requestModifier)
//        
//        
//    }
//
//    func patch(endpoint: String, body: Data?, requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
//        guard let url = URL(string: "\(baseURL)")?.appendingPathComponent(endpoint) else {
//            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.httpBody = body
//        return createPublisher(for: request, requestModifier: requestModifier)
//    }
//
//    func delete(endpoint: String, requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
//        guard let url = URL(string: baseURL), var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return Fail(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()}
//        components.path = "/dev/" + endpoint
//        components.scheme = "https"
//        guard let requestUrl = components.url else {
//            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateURL)
//                .eraseToAnyPublisher() }
//
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "DELETE"
//        return createPublisher(for: request, requestModifier: requestModifier)
//    }
//
//    func createPublisher(for request: URLRequest, requestModifier:@escaping RequestModifier) -> URLSession.ErasedDataTaskPublisher {
//        Just(request)
//            .setFailureType(to: Error.self)
//            .flatMap { [self] in
//                urlSession.erasedDataTaskPublisher(for: requestModifier($0))
//            }.eraseToAnyPublisher()
//    
//    }
//}