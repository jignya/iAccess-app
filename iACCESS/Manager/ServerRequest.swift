//
//  ServerRequest.swift


import Foundation
import ImShExtensions


class ServerRequest {
    
    /// Singleton object
    static let shared = ServerRequest()
    
//    class var isConnected: Bool {
//        let manager = NetworkReachabilityManager.init(host: "www.google.com")
//        return manager?.isReachable ?? false
//    }

    /// - Parameters:
    ///   - delegate: ServerRequestDelegate
    ///   - completion: ()
    ///   - failure: Error msg if any, String
    
    
    //MARK: - GET Method
    
    func getApiData(urlString : String, param: [String:String] , delegate: ServerRequestDelegate? = nil, completion:@escaping (_ result: [[String:Any]],_ message: [String:Any]) -> Void) -> Void
    {
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        var urlComponents = URLComponents(string: String(format: "http://localhost/ipots-kids-app/ipots-server/%@",urlString))
        
        urlComponents?.queryItems = param.map(URLQueryItem.init)
        
//            urlComponents?.queryItems = [
//                URLQueryItem(name: "method", value: "All")
////                URLQueryItem(name: "letter", value: "A")
//            ]
        
        guard let serviceUrl = urlComponents?.url else { return }
        var request = URLRequest(url: serviceUrl)
        print(serviceUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    if (json as? [String:Any]) != nil
                    {
                        let response = json as? [String : Any] ?? [:]
                        completion([], response)
                        
                    } else if json as? [[String : Any]] != nil
                    {
                        let response = json as? [[String : Any]] ?? []
                        completion(response, [:])

                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    //MARK: - POST Method
    
    func postApiData(urlString : String,params: [String:Any] , delegate: ServerRequestDelegate? = nil, completion:@escaping (_ result: [[String:Any]]) -> Void)
    {
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        let Url = String(format: "http://localhost/ipots-kids-app/ipots-server/%@",urlString)
        guard let serviceUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(params)

        guard let httpBody = try? JSONSerialization.data(withJSONObject: params) else {
               return
           }
        
        print(httpBody)
        request.httpBody = httpBody

        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in

             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data, !data.isEmpty {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("JSON Response: \(json)")
                    } catch {
                        print("Decoding Error: \(error)")
                    }
                } else {
                    print("No content in response.")
                }
            } else {
                print("HTTP Error: \(response)")
            }

           


//            if let response = response {
//                print(response)
//            }
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                    let response = json as? [[String : Any]] ?? []
//                    completion(response)
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
        }
        session.resume()
    }
    

//    func postApiData(urlString : String,params: [String:Any] , delegate: ServerRequestDelegate? = nil, completion:@escaping (_ result: Bool) -> Void) -> Void
//    {
//        DispatchQueue.main.async {
//            delegate?.isLoading(loading: true)
//        }
//
//
//        let Url = String(format: "http://localhost/ipots-kids-app/ipots-server/%@",urlString)
//        guard let serviceUrl = URL(string: Url) else { return }
//        var request = URLRequest(url: serviceUrl)
//        request.httpMethod = "POST"
//
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
//               return
//           }
//        request.httpBody = httpBody
//
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//
//             DispatchQueue.main.async {
//                delegate?.isLoading(loading: false)
//            }
//
//            if let response = response {
//                print(response)
//            }
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                    let response = json as! [String : Any]
//                    completion(response["status"] as? Bool ?? false)
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
    
    
    //MARK: Functions
    
    func GetFileUrl(Filename:String) -> URL
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let fileDataPath = documentsDirectory + "/" + Filename
        let filePathURL = URL(fileURLWithPath: fileDataPath)
        return filePathURL
    }

    
}

@objc protocol ServerRequestDelegate: class {
    func isLoading(loading: Bool)
    @objc optional func progress(value: Double)
}

//extension JSON {
//    func getRespMsg() -> String {
//        return self["message"].stringValue
//    }
//}


extension String {
    public func addingPercentEncodingForQueryParameter() -> String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)

        return allowed
    }()
}
