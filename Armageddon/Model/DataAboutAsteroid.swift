import Foundation

struct AsteroidData: Codable {

    let id, name, designation: String?

    let nasaJplURL: String?
    let absoluteMagnitudeH: Double?
    let estimatedDiameter: EstimatedDiameter?
    let isPotentiallyHazardousAsteroid: Bool?
    let closeApproachData: [CloseApproachDatum]?
    let orbitalData: OrbitalData?
    let isSentryObject: Bool?

    struct CloseApproachDatum: Codable {
        
        enum OrbitingBody: String, Codable {
            case earth
            case merc
            case venus
            
            init(from decoder: Decoder) throws {
                  let label = try decoder.singleValueContainer().decode(String.self)
                  switch label {
                     case "earth": self = .earth
                     case "merc": self = .merc
                    default: self = .venus
                  }
            }
        }
        
        let closeApproachDate, closeApproachDateFull: String?
        let epochDateCloseApproach: Int?
        let relativeVelocity: RelativeVelocity?
        let missDistance: MissDistance?
        let orbitingBody: OrbitingBody?
    }
    
    struct MissDistance: Codable {
        let astronomical, lunar, kilometers, miles: String?
    }

    struct RelativeVelocity: Codable {
        let kilometersPerSecond, kilometersPerHour, milesPerHour: String?
    }

    struct EstimatedDiameter: Codable {
        let kilometers, meters, miles, feet: Feet?
    }

    struct Feet: Codable {
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
        let orbitClassType, orbitClassRange, orbitClassDescription: String?
    }
}


