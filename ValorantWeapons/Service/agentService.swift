
import Foundation


class agentService: ObservableObject {
    
    @Published var agents: [Agent.agentModel] = []
    @Published var selectedAgentUUID: String?
    
    
    
    func requestData() async {
        guard let url = URL(string: "https://valorant-api.com/v1/agents") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Agent.self  , from: data)
            DispatchQueue.main.async {
                self.agents = decodedData.data
            }
        } catch {
            
            print("Error: \(error)")
                    
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
                        print("An unknown error occurred.")
                    }

                    print("burda sorun çıktı@@@@agent service")
                }
            }

    
    func selectAgent(withUUID uuid: String) {
        selectedAgentUUID = uuid
        print("Selected agent UUID: \(uuid)")
    }
    
    
}
