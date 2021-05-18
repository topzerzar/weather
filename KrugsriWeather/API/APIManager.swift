//
//  APIManager.swift
//  KrugsriWeather
//
//  Created by weerapon on 17/5/2564 BE.
//

import Alamofire
import SwiftyJSON
import Foundation

class APIManager {
    
    var endpoint: String = ""
    var method: HTTPMethod = .get
    static var host: String = ServiceEndPoint.BASE_URL
    
    let headersCommon: [String:String] = [
        "Content-Type": "application/json"
    ]
    
    init(endpoint: String, method: HTTPMethod = .get) {
        self.endpoint = endpoint
        self.method = method
    }
    
    public func request(
        host: String? = APIManager.host,
        parameters: [String : AnyObject],
        headersAdditional: [String : String]?,
        encoding: ParameterEncoding?,
        fail: @escaping (_ httpStatus: Int?, _ result: JSON?) -> (),
        success: @escaping (_ result: JSON) -> ()
    ) {
        
        var requestEncoding: ParameterEncoding = JSONEncoding.default
        if encoding != nil {
            requestEncoding = encoding!
        }
        
        let (params, url) = self.buildParameter(
            url: (host! + endpoint),
            method: self.method,
            parameters: parameters
        )
        
        guard let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        Alamofire.request(
            urlEncoded,
            method: self.method,
            parameters: params,
            encoding: requestEncoding,
            headers: generateHeader(headersAdditional)
        ).responseJSON { (response) in

            if response.result.isSuccess, let responseJSON = response.result.value {
                if response.response?.statusCode == 200 {
                    let json: JSON = JSON(responseJSON)
                    success(json)
                } else {
                    let json: JSON = JSON(response.result.value as Any)
                    fail(response.response?.statusCode, json)
                }
            } else {
                let json: JSON = JSON(response.result.value as Any)
                fail(response.response?.statusCode, json)
            }
        }
        
    }
    
    func generateHeader(_ headersAdditional: [String : String]?) -> [String : String] {
        var headers = headersCommon
        if headersAdditional != nil {
            for (k, v) in headersAdditional! {
                headers[k] = v
            }
        }
        
        return headers
    }
    
    
    private func buildParameter(
        url: String,
        method: HTTPMethod,
        parameters: [String : AnyObject]
    ) -> ([String:AnyObject]?, String) {
        
        var newUrl = url
        var params: [String:AnyObject]?
        
        switch method {
            case .get:
                var apiParams = ""
                for (key, name) in parameters {
                    apiParams = apiParams + key + "=" + "\(name)" + "&"
                }
                if apiParams.hasSuffix("&") {
                    apiParams = String(apiParams.dropLast())
                }
                if apiParams != "" {
                    newUrl = "\(url)?\(apiParams)"
                }
            default:
                params = parameters
        }
        
        return (params, newUrl)
    }
    
}
