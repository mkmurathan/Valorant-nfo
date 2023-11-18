
import Foundation


class mapService: ObservableObject {
    
    @Published var mapss: [mapler.mapModel] = []
    @Published var selectedMapsUUID: String?
    
    
    
    func requestData() async {
        guard let url = URL(string: "https://valorant-api.com/v1/maps") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(mapler.self  , from: data)
            DispatchQueue.main.async {
                self.mapss = decodedData.data
               
            }
        } catch {
            
            print("Error: \(error)")
            print("Error fetching map data: \(error)")
                    // Hatanın türüne göre özel bir işlem yapabilirsi‚niz
                    if let decodingError = error as? DecodingError {
                        switch decodingError {
                        case .dataCorrupted(let context):
                            print("Data Corrupted: \(context.debugDescription)")
                        case .keyNotFound(let key, let context):
                            print("Key Not Found: \(key.stringValue), Context: \(context.debugDescription)")
                        case .typeMismatch(let type, let context):
                            print("Type Mismatch: \(type), Context: \(context.debugDescription)")
                        case .valueNotFound(let type, let context):
                            print("Value Not Found: \(type), Context: \(context.debugDescription)")
                        @unknown default:
                            print("Unknown Error")
                        }
                    } else {
                        // Diğer hata türleri için genel bir mesaj yazdırabilirsiniz
                        print("An unknown error occurred.")
                    }

                    print("burda sorun çıktı@@@map service")
                }
            }

    
    func selectMap(withUUID uuid: String) {
        selectedMapsUUID = uuid
        print("Selected maps UUID: \(uuid)")
    }
    
    
}
