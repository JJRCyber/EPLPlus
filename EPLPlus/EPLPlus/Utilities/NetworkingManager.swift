//
//  NetworkingManager.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 22/9/2023.
//

import Foundation
import Combine

/*
 This class is used as an overarching networking manager using the Combine framework
 Used to streamline the download process of API data and images
 All functions are static so they can be called without an instance
 */

final class NetworkingManager {
    
    // Custom errors that are raised in this class
    enum NetworkingError: LocalizedError {
        case badUrlResponse(url: URL?)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badUrlResponse(url: let url): return "Bad Response from API: \(String(describing: url))"
            case .unknown: return "Unknown error occured"
            }
        }
    }
    
    // Downloads from a URLRequest - URLRequest allows for custom headers
    static func download(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
        
        // Subscribe on background thread for data downloading
            .subscribe(on: DispatchQueue.global(qos: .default))
        // Handles the response
            .tryMap( { try handleURLResponse(output: $0, url: request.url)})
        // Recieve data on main thread as we are updating the UI
            .receive(on: DispatchQueue.main)
        // Allows returning non-specifc publisher
            .eraseToAnyPublisher()
    }
    
    // Downloads from a plain URL - used for downloading images etc
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
        
        // Subscribe on background thread for data downloading
            .subscribe(on: DispatchQueue.global(qos: .default))
        // Handles the response
            .tryMap( { try handleURLResponse(output: $0, url: url)})
        // Recieve data on main thread as we are updating the UI
            .receive(on: DispatchQueue.main)
        // Allows returning non-specifc publisher
            .eraseToAnyPublisher()
    }
    
    // Helper function to handle response
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL?) throws -> Data {
        // Ensures response is HTTP response
        guard let response = output.response as? HTTPURLResponse,
              // Throws error if HTTP response not OK
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badUrlResponse(url: url)
        }
        return output.data
    }
    
    // Handles the completion which includes decoding from API to struct
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            // Error is printed to console rather than displayed to user as this is for debugging only
            print("Decoding failed with error: \(error)")
        }
    }
}
