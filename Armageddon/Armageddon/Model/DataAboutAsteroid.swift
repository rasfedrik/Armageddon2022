import Foundation

struct AsteroidData: Codable {

    let id, name, designation: String?

    let nasaJplURL: String?
    let absoluteMagnitudeH: Double?
    let estimatedDiameter: EstimatedDiameter?
    let isPotentiallyHazardousAsteroid: Bool?
    let closeApproachData: [CloseApproachDatum]?
    let isSentryObject: Bool?

    struct CloseApproachDatum: Codable {
        
        enum OrbitingBody: String, Codable {
            case merc = "Меркурий"
            case venus = "Венера"
            case earth = "Земля"
            case mars = "Марс"
            
            init(from decoder: Decoder) throws {
                  let label = try decoder.singleValueContainer().decode(String.self)
                  switch label {
                    case "Merc": self = .merc
                    case "Venus": self = .venus
                    case "Earth": self = .earth
                    default: self = .mars
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
}


