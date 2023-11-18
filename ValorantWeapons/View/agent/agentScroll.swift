





import SwiftUI
import Combine


struct agentScroll: View {
    
    @StateObject var AgentViewModel = agentViewModel()
    @State private var selectedCategory: String?
    
    
    
    func agentImageView(url: URL?) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                
            case .failure(let error):
                Text("Error loading image: \(error.localizedDescription)")
            @unknown default:
                EmptyView()
            }
        }
    }
    
    struct CustomButtonStyle: ButtonStyle {
        var isSelected: Bool
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(isSelected ? .red : .white)
                .font(.custom("VALORANT-Regular", size: 15))
        }
    }
    
    var body: some View {
        
        
        NavigationView{
            
            ZStack {
                
                VStack {
                    
                    HStack(spacing: 10) {
                        ForEach(["all", "Controller", "Duelist", "Initiator", "Sentinel"], id: \.self) { category in
                            Button(category) {
                                selectedCategory = category
                                AgentViewModel.filterAgentsByCategory(category)
                            }
                            .buttonStyle(CustomButtonStyle(isSelected: selectedCategory == category))
                        }
                    }
                    .font(.custom("VALORANT-Regular", size: 15))
                    
                    Divider()
                        .background(Color.white)
                        .frame(height: 2)
                    
                    
                    
                    ScrollView (.vertical, showsIndicators: false, content:  {
                        
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                            
                            ForEach(AgentViewModel.filteredAgents) { agent in
                                
                                NavigationLink(destination: AgentDetailView(agent: agent)) {
                                    
                                    GeometryReader { geometry in
                                        
                                        VStack (spacing: 10){
                                            
                                            
                                            
                                            ZStack {
                                                agentImageView(url: URL(string: agent.background ?? ""))
                                                    .opacity(0.5)
                                                   
                                                
                                                agentImageView(url: URL(string: agent.fullPortrait ?? ""))
                                                
                                                
                                            } .frame(width: 150, height: 150)
                                                .cornerRadius(25.0)
                                                .shadow(radius: 10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 25.0)
                                                        .stroke(Color.gray, lineWidth: 2)
                                                ).padding([.leading, .trailing], 15)
                                            
                                            HStack {
                                                
                                                Text("\(agent.displayName) //")
                                                    .font(.custom("VALORANT-Regular", size: 15))
                                                    .foregroundStyle(Color.red)
                                                    .layoutPriority(1)
                                                
                                                Text(agent.role?.displayName.rawValue ?? "")
                                                    .font(.custom("VALORANT-Regular", size: 10))
                                                    .foregroundColor(.gray)
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                        } .scrollTransition(topLeading: .interactive, bottomTrailing: .interactive, axis: .vertical) { effect, phase in
                                            effect
                                                .scaleEffect(1 - abs(phase.value))
                                                .rotationEffect(.degrees(phase.value * 90 ))
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                    .aspectRatio(1.0, contentMode: .fit)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        
                    }) // scrollview bitişi
                    
                } // VStack bitişi
                
                .onAppear {
                    // selectedCategory = "All"
                    AgentViewModel.getAgents()
                    // AgentViewModel.getAllAgents()
                    
                    
                }
                
                
            }.background(Color.black)   // ZStack bitişi
                .navigationBarItems(leading:
                                        HStack {
                    Text("AGENTS")
                        .foregroundColor(.red)
                        .font(.custom("VALORANT-Regular", size: 35))
                    
                }
                )
            
        } // navigationView bitişi
        
    }
    
    
    
}

#Preview {
    agentScroll()
}
