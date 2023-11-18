


import Foundation


// MARK: - Welcome
struct mapler: Codable {
    let status: Int
    let data: [mapModel]
    
    
    // MARK: - Datum
   

    struct mapModel: Codable, Identifiable {
        let uuid: String
        let displayName: String
        let narrativeDescription: String?
        let tacticalDescription: String?
        let coordinates: String?
        let displayIcon: String?
        let listViewIcon: String
        let listViewIconTall: String?
        let splash: String
        let stylizedBackgroundImage: String?
        let premierBackgroundImage: String?
        let assetPath: String
        let xMultiplier: Double
        let yMultiplier: Double
        let xScalarToAdd: Double
        let yScalarToAdd: Double

        var id: String {
            return uuid
        }
    }

 

    struct Location: Codable {
        let x: Double
        let y: Double
    }

}

enum SuperRegionName: String, Codable {
    case a = "A"
    case attackerSide = "Attacker Side"
    case b = "B"
    case c = "C"
    case defenderSide = "Defender Side"
    case mid = "Mid"
}

enum TacticalDescription: String, Codable {
    case aBCSites = "A/B/C Sites"
    case aBSites = "A/B Sites"
}






