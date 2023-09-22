//
//  NetworkingManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine

final class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badUrlResponse(url: URL?)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badUrlResponse(url: let url): return "[🔥] Bad Response from API: \(String(describing: url))"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
    
    
    static func download(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            // Subscribe on background thread for data downloading
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap( { try handleURLResponse(output: $0, url: request.url)})
            // Recieve data on main thread as we are updating the UI
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            // Subscribe on background thread for data downloading
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap( { try handleURLResponse(output: $0, url: url)})
            // Recieve data on main thread as we are updating the UI
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL?) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badUrlResponse(url: url)
        }
//        print(String(data: output.data, encoding: .utf8))
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Decoding failed with error: \(error)")
        }
    }
}
