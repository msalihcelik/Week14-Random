//
//  Service.swift
//  Week14-Random
//
//  Created by Mehmet Salih ÇELİK on 26.01.2022.
//

import Foundation
import Alamofire

enum NMError: Error {
    case invalidURL
    case noResponse
    case dataFailure
    case couldNotDecodeData
}

class Service {

    static let shared = Service()

    func getData<T: Codable>(url: String, type: T.Type, completion: @escaping (Result<T, NMError>) -> Void) {

        guard let url = URL(string: url) else { return }
        AF.request(url).response { (response) in

            if let error = response.error {
                completion(.failure(.invalidURL))
                debugPrint(error.localizedDescription)
                return
            }

            guard let data = response.data else {
                completion(.failure(.dataFailure))
                return
            }

            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.couldNotDecodeData))
                debugPrint(error.localizedDescription)
            }
        }
    }
}
