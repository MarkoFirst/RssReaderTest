//
//  NewsPresenter.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation
import Unbox

class NewsPresenter {
    func sources(_ completion: @escaping ([Source]?) -> Void) {
        if let sourceList = CoreDataManager.shared.getSourceList(), !sourceList.isEmpty {
            completion(sourceList)
            return
        }
        
        apiProvider.requestHandler(
            .sources,
            completion: { value in
                guard let data = (try value.mapJSON() as? [String: Any])?["sources"] as? Array<[String: String]> else {
                    completion(nil)
                    return
                }

//                let response: [Source] = try data.map({ try unbox(dictionary: $0)}).compactMap { $0 }
                let response: [Source] = data.map { CoreDataManager.shared.saveSource($0) }.compactMap { $0 }
                
                completion(response)
            }
        )
    }
    
    func everything(sourceId: String, query: String = "", _ completion: @escaping ([News]?) -> Void) {
        apiProvider.requestHandler(
            .everything(sourceId, query),
            completion: { value in
                guard let data = (try value.mapJSON() as? [String: Any])?["articles"] as? Array<[String: Any]> else {
                    completion(nil)
                    return
                }
                
                let response: [News] = try data.map { try unbox(dictionary: $0)} .compactMap { $0 }
                completion(response)
            }
        )
    }
}
