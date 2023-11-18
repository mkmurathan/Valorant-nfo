


import Foundation


// MARK: - Welcome
struct Agent: Codable {
    let status: Int
    let data: [agentModel]
    
    
    // MARK: - Datum
    struct agentModel: Codable, Identifiable {
        
        
        let uuid, displayName, description, developerName: String
        let characterTags: [String]?
        let displayIcon, displayIconSmall: String
        let bustPortrait, fullPortrait, fullPortraitV2: String?
        let killfeedPortrait: String
        let background: String?
        let backgroundGradientColors: [String]
        let assetPath: String
        let isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, isBaseContent: Bool
        let role: Role?
        let abilities: [Ability]
        
        
        
        
        var id: String {
            return uuid
        }
    }
}
// MARK: - Ability
struct Ability: Codable,Hashable {
    let slot: Slot
    let displayName, description: String
    let displayIcon: String?
}

enum Slot: String, Codable {
    case ability1 = "Ability1"
    case ability2 = "Ability2"
    case grenade = "Grenade"
    case passive = "Passive"
    case ultimate = "Ultimate"
}



// MARK: - Role
struct Role: Codable {
    let uuid: String
    let displayName: DisplayName
    let description: String
    let displayIcon: String
    let assetPath: String
}

enum DisplayName: String, Codable {
    case controller = "Controller"
    case duelist = "Duelist"
    case initiator = "Initiator"
    case sentinel = "Sentinel"
}


