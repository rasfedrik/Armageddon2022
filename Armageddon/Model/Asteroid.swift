//
//  Asteroid.swift
//  Armageddon
//
//  Created by Семен Беляков on 13.04.2022.
//

import Foundation

//class NewAsteroid {
//    var arr: [Asteroid] {
//        get {
//            var result = [Asteroid]()
//
//        }
//    }
//}

struct Object {
    let title: String?
    let data: [NearEarthObject]?
}


// MARK: - Asteroid
struct Asteroid: Codable {
//    let links: AsteroidLinks?
//    let elementCount: Int?
    let nearEarthObjects: [String: [NearEarthObject]]?
    
    var earthObjects: [Object] {
        get {
            var result = [Object]()
            guard let nearEarthObjects = nearEarthObjects else { return result }
            
            for (key, value) in nearEarthObjects {
                result.append(.init(title: key, data: value))
            }
            return result
        }
    }

    enum CodingKeys: String, CodingKey {
//        case links
//        case elementCount
        case nearEarthObjects
    }
}

// MARK: - AsteroidLinks
//struct AsteroidLinks: Codable {
//    let next, prev, linksSelf: String?
//
//    enum CodingKeys: String, CodingKey {
//        case next, prev
//        case linksSelf
//    }
//}

// MARK: - NearEarthObject
struct NearEarthObject: Codable {
    let links: NearEarthObjectLinks?
    let id, neoReferenceID, name: String?
    let nasaJplURL: String?
    let absoluteMagnitudeH: Double?
    let estimatedDiameter: EstimatedDiameter?
    let isPotentiallyHazardousAsteroid: Bool?
    let closeApproachData: [CloseApproachDatum]?
    let isSentryObject: Bool?

    enum CodingKeys: String, CodingKey {
        case links, id
        case neoReferenceID
        case name
        case nasaJplURL
        case absoluteMagnitudeH
        case estimatedDiameter
        case isPotentiallyHazardousAsteroid
        case closeApproachData
        case isSentryObject
    }
}

// MARK: - CloseApproachDatum
struct CloseApproachDatum: Codable {
    let closeApproachDate, closeApproachDateFull: String?
    let epochDateCloseApproach: Int?
    let relativeVelocity: RelativeVelocity?
    let missDistance: MissDistance?
    let orbitingBody: OrbitingBody?

    enum CodingKeys: String, CodingKey {
        case closeApproachDate
        case closeApproachDateFull
        case epochDateCloseApproach
        case relativeVelocity
        case missDistance
        case orbitingBody
    }
}

// MARK: - MissDistance
struct MissDistance: Codable {
    let astronomical, lunar, kilometers, miles: String?
}

enum OrbitingBody: String, Codable {
    case earth = "Earth"
}

// MARK: - RelativeVelocity
struct RelativeVelocity: Codable {
    let kilometersPerSecond, kilometersPerHour, milesPerHour: String?

    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond
        case kilometersPerHour
        case milesPerHour
    }
}

// MARK: - EstimatedDiameter
struct EstimatedDiameter: Codable {
    let kilometers, meters, miles, feet: Feet?
}

// MARK: - Feet
struct Feet: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double?

    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin
        case estimatedDiameterMax
    }
}

// MARK: - NearEarthObjectLinks
struct NearEarthObjectLinks: Codable {
    let linksSelf: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf
    }
}
