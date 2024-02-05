


import Foundation

class WeaponViewModel: ObservableObject {
    
    @Published var weapons: [Weapon.WeaponModel] = []
    @Published var selectedWeaponUUID: String?
    @Published var filteredWeapons: [Weapon.WeaponModel] = []
    
    
    private var weaponservice = weaponService()
    
    func printWeapons() {
        print("Weapons:")
        for weaponModel in weapons {
            print("UUID: \(weaponModel.uuid), DisplayName: \(weaponModel.displayName), Category: \(weaponModel.category)")

            if let weaponStats = weaponModel.weaponStats {
                print("Weapon Stats:")
                print("  Fire Rate: \(weaponStats.fireRate)")
                print("  Magazine Size: \(weaponStats.magazineSize)")
            } else {
                print("Weapon Stats: Nil")
            }
        }
    }

    
    
    func getAllWeapons() {
        filteredWeapons = weapons
    }
  
    func filterWeaponsByCategory(_ category: String?) {
        print("Seçilen Kategori: \(category ?? "nil")")
        
        if let category = category, !category.isEmpty, category.lowercased() != "all" {
            let formattedCategory = "EEquippableCategory::" + category
            filteredWeapons = weapons.filter {
                $0.category.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == formattedCategory.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            }
        } else {
            filteredWeapons = weapons
        }
        
        print("Filtrelenmiş Silah Sayısı: \(filteredWeapons.count)")
    }




    
    
    func selectWeapon(withUUID uuid: String) {
        selectedWeaponUUID = uuid
        
        if let selectedUUID = selectedWeaponUUID, !selectedUUID.isEmpty {
          
            print("Selected weapon UUID: \(selectedUUID)")
        } else {
            print("Error: Selected UUID is empty or nil.@@@@@@@@")
        }
    }
    
    func getWeapons() {
        Task {
            do {
                await weaponservice.requestData()
                
                DispatchQueue.main.async {
                    self.weapons = self.weaponservice.weapons
                    print("weapons fetched successfully")
                    for weaponModel in self.weapons {
                                           print("Weapon Category: \(weaponModel.category)")
                                       }
                }
                
                
             
                
            } catch {
                print("Error fetching weapon data: \(error)")
            }
        }
    }
    
  
    
}

