//
//  API.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]
typealias Path = String

enum TWError: Error {
  case API(description: String)
  case connection(description: String, code: Int)
  case unknown
}

struct API {
  private static let key: String = ProcessInfo.processInfo.environment["USER_PRIVATE_KEY"]!
  private static let baseURL: String  = "yat.teamwork.com"
  
  enum Method: String {
    case get = "GET",
    post = "POST",
    put = "PUT"
  }
  
  private enum Header: String {
    case auth = "Authorization",
    accept = "Accept",
    contentType = "Content-Type"
  }
  
  typealias AuthRequest = URLRequest
  
  static func request(path: String, method: Method, body: JSON? = nil) -> AuthRequest {
    // https://developer.teamwork.com/introduction#so_how_do_you_get
    /* "Use your API token as the username, and "X" (or some otherwise bogus text)
     as the password (only the API token is used for authenticating API requests)." */
    let data = "\(key):X".data(using: .utf8)!
    let encoded = data.base64EncodedString()
    let url = URL(string: "https://\(baseURL)/\(path).json")!
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.setValue("Basic \(encoded)", forHTTPHeaderField: Header.auth.rawValue)
    request.setValue("application/json", forHTTPHeaderField: Header.accept.rawValue)
    request.setValue("application/json", forHTTPHeaderField: Header.contentType.rawValue)
    
    if let body = body,
      let data = try? JSONSerialization.data(withJSONObject: body) {
      request.httpBody = data
    }
    
    return request
  }
  
  static func perform(_ request: AuthRequest, completion: @escaping (_ json: JSON?, _ error: TWError?) -> Void) {
    
    // To go back to main thread
    func complete(json: JSON?, error: TWError?) {
      DispatchQueue.main.async {
        completion(json, error)
      }
    }
    
    DispatchQueue.global(qos: .background).async {
      URLSession.shared.dataTask(with: request) { data, response, error in
        
        // If there's a connection problem
        if let error = error {
          complete(json: nil, error: TWError.connection(description: error.localizedDescription, code: (error as NSError).code))
          return
        }
        
        // If we receive some data back
        guard let data = data else {
          complete(json: nil, error: TWError.unknown)
          return
        }
        
        // If we are able to convert data to JSON
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments), let json = jsonObject as? JSON else {
          complete(json: nil, error: TWError.API(description: "JSON not well formatted"))
          return
        }
        
        // If the API has returned an error
        guard let status = json["STATUS"] as? String, status == "OK" else {
          if let message = json["MESSAGE"] as? String {
            print(message)
            complete(json: nil, error: TWError.API(description: message))
          } else {
            complete(json: nil, error: TWError.API(description: "API returning STATUS is not OK without message"))
          }
          return
        }
        
        // All looks good
        complete(json: json, error: nil)
      }.resume()
    }
  }
}
