


import Foundation

class agentViewModel: ObservableObject {
    
    @Published var agents: [Agent.agentModel] = []
    @Published var selectedAgentUUID: String?
    @Published var filteredAgents: [Agent.agentModel] = []

    
    private var AgentService = agentService()
    
    
    func filterAgentsByCategory(_ category: String?) {
        print("Selected Category: \(category ?? "nil")")
        
        if let category = category, category.lowercased() != "all" {
            filteredAgents = agents.filter { $0.role?.displayName.rawValue.lowercased() == category.lowercased() }
        } else {
            filteredAgents = agents
        }
        
        print("Filtered Agents Count: \(filteredAgents.count)")
    }

    
    func getAllAgents() {
        filteredAgents = agents
    }


    func selectAgent(withUUID uuid: String) {
        selectedAgentUUID = uuid
        
        if let selectedUUID = selectedAgentUUID, !selectedUUID.isEmpty {
          
            print("Selected Agent UUID: \(selectedUUID)")
        } else {
            print("Error: Selected UUID is empty or nil.@@@@@@@@")
        }
    }
    
    func getAgents() {
        Task {
            do {
                await AgentService.requestData()
                
                // Veriyi ana thread üzerinde güncelle
                DispatchQueue.main.async {
                    self.agents = self.AgentService.agents
                    print("Agents fetched successfully")
                }
                
              
                
            } catch {
                print("Error fetching agent data: \(error)")
            }
        }
    }


}
