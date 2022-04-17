//
//  NetworkManager.swift
//  Armageddon
//
//  Created by Семен Беляков on 13.04.2022.
//

import Foundation

class NetworkManager {

//    private let apiKey = "c923f2eYX6lDo6ouo3dgbhoryYXDADYdKcGrzagO"
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    private let baseURL = URL(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=2015-09-07&end_date=2015-09-08&api_key=c923f2eYX6lDo6ouo3dgbhoryYXDADYdKcGrzagO")

    func obtainAsteroids(completion: @escaping (SpaceObjects) -> Void) {

        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let urlString = "\(baseURL!)"

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
}




//"id": "2465633",

//      "name": "465633 (2009 JR5)", // Имя


//      "estimated_diameter": { // Диаметр

//        "meters": {
//          "estimated_diameter_min": 225.1930466786,
//          "estimated_diameter_max": 503.5469604336
//        },

//      },
//      "is_potentially_hazardous_asteroid": true, // Опасность
//      "close_approach_data": [
//        {
//          "close_approach_date": "2015-09-08", // Время сближения
//          "close_approach_date_full": "2015-Sep-08 20:28",
//          "epoch_date_close_approach": 1441744080000,

//          "miss_distance": { // Дистанция подлета

//            "lunar": "117.7689258646",
//            "kilometers": "45290438.204452618",
//          },
//          "orbiting_body": "Earth"
//        }
//      ],
//      "is_sentry_object": false // ХЗ
//    },
