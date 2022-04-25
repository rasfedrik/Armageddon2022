//
//  NetworkManager.swift
//  Armageddon
//
//  Created by Семен Беляков on 13.04.2022.
//

import Foundation

class NetworkManager {

    private let apiKey = "api_key=c923f2eYX6lDo6ouo3dgbhoryYXDADYdKcGrzagO"
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let baseURLAsteroid = URL(string:"https://api.nasa.gov/neo/rest/v1/neo/")
    private let baseURL = URL(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=2022-09-07&")

    func obtainAsteroids(completion: @escaping (SpaceObjects) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let urlString = "\(baseURL!)\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let strongSelf = self else { return }
            
            guard let data = data else { return }

                do {
                    let asteroid = try strongSelf.decoder.decode(SpaceObjects.self, from: data)
                    completion(asteroid)
                } catch {
                    print(error)
                }
        }.resume()
    }
    
    // Получение подробной информации об астероиде
    func asteroidData(id: String, completion: @escaping (AsteroidData) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let urlString = "\(baseURLAsteroid!)\(id)?\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let strongSelf = self else { return }
            
            guard let data = data else { return }

                do {
                    let asteroid = try strongSelf.decoder.decode(AsteroidData.self, from: data)
                    completion(asteroid)
                } catch {
                    print(error)
                }
        }.resume()
    }
    
    
    
    
    
    
}
