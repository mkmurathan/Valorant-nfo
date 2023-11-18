


import Foundation

class mapsViewModel: ObservableObject {
    @Published var maps: [mapler.mapModel] = []
    @Published var selectedMapsUUID: String?
    
    
    private var MapService = mapService()
    
    func selectWeapon(withUUID uuid: String) {
        selectedMapsUUID = uuid
    
        if let mapuuıd = selectedMapsUUID, !mapuuıd.isEmpty {
            print(mapuuıd)
        } else {
            print("map uuıd gelmedi")
        }
        
    }
    
    func getMaps() async {
        Task {
            do {
                await MapService.requestData()
                
                DispatchQueue.main.async {
                    self.maps = self.MapService.mapss
                    print("maps fetched successfully")
                }
              
            } catch {
                print("Error fetching maps data: \(error)")
            }
    }
    
 }
  
}
