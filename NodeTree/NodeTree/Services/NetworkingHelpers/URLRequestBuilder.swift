//
//  TreeEndPoint.swift
//  NodeTree
//
//  Created by Alaa Eid on 02/01/2024.
//

import Foundation

class URLRequestBuilder: APIRequest {
    
    var baseURL: URL {
        guard let url = URL(string: "http://localhost:3000/") else {
            fatalError("Invalid base URL")
        }
        return url
    }
    var path: EndPoint
    var method: HTTPMethod = .get
    var headers: [String: Any]?
    var parameters: RequestParams?
    private var fileData: Data?
    private var fileName: String?
    
    init(path: EndPoint) {
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
    
    @discardableResult
    func setFileData(_ fileData: Data) -> Self {
        self.fileData = fileData
        return self
    }
    
    @discardableResult
    func setFileName(_ fileName: String) -> Self {
        self.fileName = fileName
        return self
    }
    
    

    func build() -> URLRequest {
        
            var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path.rawValue),
                                        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                        timeoutInterval: 100)
            urlRequest.httpMethod = method.rawValue
            
            headers?.forEach {
                urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
            }
       
            if let parameters = parameters {
                if case let RequestParams.body(param) = parameters  {
                    urlRequest.httpBody = try? JSONEncoder().encode(param)

                } else if case let RequestParams.multipart(param) = parameters {
                    let boundary = "Boundary-\(UUID().uuidString)"
                    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                    
                    var body = [UInt8]()
                    
                    // Append parameters
                    for (key, value) in param {
                        body += "--\(boundary)\r\n".utf8
                        body += "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8
                        body += "\(value)\r\n".utf8
                    }
                    
                    // Append file data
                    if let fileData = fileData, let fileName = fileName {
                        body += "--\(boundary)\r\n".utf8
                        body += "Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".utf8
                        body += "Content-Type: application/octet-stream\r\n\r\n".utf8
                        body += fileData
                        body += "\r\n".utf8
                    }
                    
                    // Closing boundary
                    body += "--\(boundary)--\r\n".utf8
                    
                    urlRequest.httpBody = Data(bytes: body)
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
            
        case .multipart(_):
            return nil
        }
    
    }
}

