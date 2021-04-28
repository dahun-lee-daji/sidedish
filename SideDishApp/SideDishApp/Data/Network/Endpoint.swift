//
//  Endpoint.swift
//  SideDishApp
//
//  Created by 오킹 on 2021/04/21.
//

import Foundation

struct Endpoint {
    private var path: String
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "3.35.220.240"
        components.port = 8080
        components.path = "/categories/\(path)"
        
        let url = components.url

        return url
    }
    
    static func get(path: String) -> Self {

        return Endpoint(path: path)
    }
}
