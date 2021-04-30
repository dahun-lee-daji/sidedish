//
//  Endpoint.swift
//  SideDishApp
//
//  Created by 오킹 on 2021/04/21.
//

import Foundation

struct Endpoint {
    
    enum APICase: String {
        case category = "categories"
        case dishes = "dishes"
    }
    private var apiCase: APICase
    private var path: String
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "3.35.220.240"
        components.port = 8080
        components.path = "/\(apiCase.rawValue)/\(path)"
        let url = components.url
        return url
    }
    
    static func get(apiCase: APICase, path: String) -> Self {

        return Endpoint(apiCase: apiCase, path: path)
    }
}
