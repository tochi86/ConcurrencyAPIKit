//
//  DelayRequest.swift
//  ConcurrencyAPIKit
//
//  Created by Toshiya Kobayashi on 2022/09/16.
//

import APIKit
import Foundation

struct DecodableDataParser: DataParser {
    var contentType: String? {
        "application/json"
    }

    func parse(data: Data) throws -> Any {
        data
    }
}

struct DelayRequest: Request {
    typealias Response = DelayResponse

    var baseURL: URL {
        URL(string: "https://httpbin.org")!
    }

    var method: HTTPMethod {
        .get
    }

    var path: String {
        "/delay/5"
    }

    var dataParser: DataParser {
        DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

struct DelayResponse: Decodable {
    let url: URL
}
