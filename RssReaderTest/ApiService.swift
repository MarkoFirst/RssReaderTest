//
//  ApiService.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Moya
import Unbox

let apiProvider = MoyaProvider<ApiService>(plugins: [])

enum ApiService {
    case sources
    case everything(_ sourceId: String, _ query: String)
}

extension ApiService: TargetType {
    var baseURL: URL {
        return Config.apiURL
    }
    
    var headers: [String : String]? {
        return ["x-api-key": Config.apiKey]
    }
    
    var path: String {
        switch self {
        case .sources:
            return "top-headlines/sources"
        case .everything:
            return "everything"
        }
    }
    
    var parameters: [String: Any]? {
        let params: [String: Any]
        
        switch self {
        case .everything(let sourceId,let query):
            params = [
                "sources": sourceId,
                "q": query,
                "from": "2022-02-01",//Date().formattedString("yyyy-MM-dd"),
                "sortBy": "popularity"
            ]
        default:
            params = [:]
        }

        return params
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return "Test data".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestParameters(parameters: self.parameters ?? [:], encoding: self.parameterEncoding)
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self.method {
        case .get,
             .delete,
             .head:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
