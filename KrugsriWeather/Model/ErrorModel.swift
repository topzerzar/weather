//
//  ErrorModel.swift
//  KrugsriWeather
//
//  Created by weerapon on 18/5/2564 BE.
//

import SwiftyJSON

class ErrorModel {
    
    var code: String?
    var message: String?
    
    init(from json: JSON) {
        self.code = json["cod"].string
        self.message = json["message"].string
    }
    
}
