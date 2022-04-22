//
//  Asteroid.swift
//  Armageddon
//
//  Created by Семен Беляков on 13.04.2022.
//

import Foundation

struct SpaceObjects: Codable {
    let nearEarthObjects: [String: [NearEarthObject]]?
    
    struct NearEarthObject: Codable {
        let id, neoReferenceID, name: String?
        let estimatedDiameter: EstimatedDiameter?
        let isPotentiallyHazardousAsteroid: Bool?
        let closeApproachData: [CloseApproachDatum]?
        let isSentryObject: Bool?
    }

    struct CloseApproachDatum: Codable {
        let closeApproachDate, closeApproachDateFull: String?
        let epochDateCloseApproach: Int?
        let relativeVelocity: RelativeVelocity?
        let missDistance: MissDistance?
        let orbitingBody: String?
    }

    struct MissDistance: Codable {
        let lunar, kilometers: String?
    }

    struct RelativeVelocity: Codable {
        let kilometersPerSecond, kilometersPerHour, milesPerHour: String?
    }

    struct EstimatedDiameter: Codable {
        let meters: Diametr?
    }

    struct Diametr: Codable {
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

    struct OrbitClass: Codable {
        let orbitClassType, orbitClassDescription, orbitClassRange: String?
    }
}
