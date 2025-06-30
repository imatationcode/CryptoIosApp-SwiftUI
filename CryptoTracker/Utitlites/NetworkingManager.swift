//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 29/06/25.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse
        case invalidData
        case decodingFailed
        case unkonwn
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse:
                return "🔥 Bad URL Response"
            case .invalidData:
                return "🚫 Invalid Data"
            case .decodingFailed:
                return "😩 Decoding Failed"
            case .unkonwn:
                return "‼️ Unkonwn Error accured"
            }
        }
    }
    
    static func fetchData(from url: URL) -> AnyPublisher<Data, any Error> {
        // 2. Create a URLRequest to add headers.
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 3. Access the API key from your Credentials struct.
        let apiKey = APICredentials.coingeckoAPIKey
        
        // 4. Set the headers required by the API.
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(apiKey, forHTTPHeaderField: "x-cg-demo-api-key")
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .tryMap ({ try handdleURLResponse(output: $0)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    //TO handle response
    static func handdleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
    //To handdle Completion
    static func handdleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print( error.localizedDescription)
        case .finished:
            print("Finished")
        }
    }
}
