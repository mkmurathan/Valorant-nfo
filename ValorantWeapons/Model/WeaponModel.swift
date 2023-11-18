import Foundation

struct Weapon: Codable {
    let status: Int
    let data: [WeaponModel]
    
    
    // MARK: - Datum
    struct WeaponModel: Codable, Identifiable {
        let uuid, displayName, category: String
        let displayIcon, killStreamIcon: String
        let assetPath: String
        let weaponStats: WeaponStats?
        let shopData: ShopData?
        let skins: [Skin]
        var id: String {
            return uuid
        }
        
        
    }
}

struct Skin: Codable, Identifiable {
    let uuid: String
    let displayIcon: String?
   
    var id: String {
            return uuid
        }
}



// MARK: - ShopData
struct ShopData: Codable, Hashable {
    let cost: Int
    let category, categoryText: String
    let canBeTrashed: Bool
}




struct WeaponStats: Codable {
    let fireRate: Double
    let magazineSize: Int
    let runSpeedMultiplier, equipTimeSeconds, reloadTimeSeconds, firstBulletAccuracy: Double
    let shotgunPelletCount: Int
    let feature, fireMode: String?
    let damageRanges: [DamageRange]
}



// MARK: - DamageRange
struct DamageRange: Codable, Hashable {
    let rangeStartMeters, rangeEndMeters: Int
    let headDamage: Double
    let bodyDamage: Int
    let legDamage: Double
}



