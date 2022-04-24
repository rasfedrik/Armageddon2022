//
//  Asteroid.swift
//  Armageddon
//
//  Created by Семен Беляков on 13.04.2022.
//

import Foundation
    
struct SpaceObjects: Codable {
    let nearEarthObjects: [String: [NearEarthObject]]?
    

    struct NearEarthObject: Codable, Equatable {
        static func == (lhs: SpaceObjects.NearEarthObject, rhs: SpaceObjects.NearEarthObject) -> Bool {
            return
                lhs.closeApproachData == rhs.closeApproachData &&
                lhs.estimatedDiameter == rhs.estimatedDiameter
        }
        
        let id, neoReferenceID, name: String?
        let estimatedDiameter: EstimatedDiameter?
        let closeApproachData: [CloseApproachDatum]?
        let isSentryObject, isPotentiallyHazardousAsteroid: Bool?
    }

    struct CloseApproachDatum: Codable, Equatable {
        static func == (lhs: SpaceObjects.CloseApproachDatum, rhs: SpaceObjects.CloseApproachDatum) -> Bool {
            return
                lhs.relativeVelocity == rhs.relativeVelocity &&
                lhs.missDistance == rhs.missDistance
        }
        
        let closeApproachDate, closeApproachDateFull: String?
        let epochDateCloseApproach: Int?
        let relativeVelocity: RelativeVelocity?
        let missDistance: MissDistance?
        let orbitingBody: String?
    }

    struct MissDistance: Codable, Equatable {
        let lunar, kilometers: String?
    }

    struct RelativeVelocity: Codable, Equatable {
        let kilometersPerSecond, kilometersPerHour, milesPerHour: String?
    }

    struct EstimatedDiameter: Codable, Equatable {
        static func == (lhs: SpaceObjects.EstimatedDiameter, rhs: SpaceObjects.EstimatedDiameter) -> Bool {
            return lhs.meters == rhs.meters
        }
        let meters: Diametr?
    }

    struct Diametr: Codable, Equatable {
        let estimatedDiameterMin, estimatedDiameterMax: Double?
    }

    struct OrbitalData: Codable {
        let orbitID, orbitDeterminationDate, firstObservationDate, lastObservationDate: String?
        let dataArcInDays, observationsUsed: Int?
        let orbitUncertainty, minimumOrbitIntersection, jupiterTisserandInvariant, epochOsculation: String?
        let eccentricity, semiMajorAxis, inclination, ascendingNodeLongitude: String?
        let orbitalPeriod, perihelionDistance, perihelionArgument, aphelionDistance: String?
        let perihelionTime, meanAnomaly, meanMotion, equinox: String?
        let orbitClass: OrbitClass?
    }

    struct OrbitClass: Codable, Equatable {
        let orbitClassType, orbitClassDescription, orbitClassRange: String?
    }
}

