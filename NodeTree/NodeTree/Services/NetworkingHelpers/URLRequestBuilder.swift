//
//  TreeEndPoint.swift
//  NodeTree
//
//  Created by Alaa Eid on 02/01/2024.
//

import Foundation

class URLRequestBuilder: APIRequest {
    var baseURL: URL
    var path: EndPoint
    var method: HTTPMethod = .get
    var headers: [String: Any]?
    var parameters: RequestParams?
    
    init(with baseURL: URL = URL(string: "http://localhost:3000/")!, path: EndPoint) {
        self.baseURL = baseURL
        self.path = path
    }
    
    @discardableResult
    func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    


    @discardableResult
    func set(headers: [String: Any]?) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    func set(parameters: RequestParams?) -> Self {
        self.parameters = parameters
        return self
    }
    

    func build() throws -> URLRequest {
        do {
            var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path.rawValue),
                                        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                        timeoutInterval: 100)
            urlRequest.httpMethod = method.rawValue
            
            headers?.forEach {
                urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
            }
       
            if let parameters = parameters {
                if case let RequestParams.body(param) = parameters  {
                    urlRequest.httpBody = try JSONEncoder().encode(param)

                } else {
                    if let requestURL = buildRequestParams(with: path.rawValue,
                                                                    parameters: parameters) {
                        
                        urlRequest = URLRequest(url: requestURL,
                                                cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                                timeoutInterval: 100)
                    
                    }
                }
            }
         
            return urlRequest
        } catch {
            throw APIErrors.requestBuilderFailed
        }
    }




    
   
    private func buildRequestParams(with path: String, parameters: RequestParams) -> URL?  {
        switch parameters {
        case .body:
             return nil
            
        case .url(let parameter):
            let queryParameter = parameter?.map({
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }) ?? []
            let fullPath = URL(string: path, relativeTo: baseURL)?.appending(queryItems: queryParameter)
            
            return fullPath
            
        case .path(let parameter):
            let parameterString = parameter?.map { "\($0.key)=\($0.value)" }.joined(separator: "&") ?? ""
            let fullPath = "\(path)/\(parameterString)"
            return URL(string: fullPath, relativeTo: baseURL)
        }
    
    }
}

