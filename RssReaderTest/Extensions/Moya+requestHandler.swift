//
//  Moya+requestHandler.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation
import Moya

extension MoyaProvider {
    func requestHandler( _ target: Target,
                        callbackQueue: DispatchQueue? = .none,
                        progress: ProgressBlock? = .none,
                        completion: @escaping (Response) throws -> Void ) {
        self.request(
            target,
            callbackQueue: callbackQueue,
            progress: progress,
            completion: { result in
                switch result {
                case .success(let response):
                    if response.statusCode < 300 {
                        do {
                            try completion(response)
                        } catch {
                            print("requestHandler error \(target.path) \(target.sampleData.base64EncodedString())")
                        }
                    } else {
                        print("\(target.path): \(response.statusCode)")
                    }
                case .failure(let error):
                    print("\(target.path): \(error.errorCode)")
                }
            }
        )
    }
}
