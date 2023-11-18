

import SwiftUI



struct AgentDetailView: View {
    var agent: Agent.agentModel
    
    var backgroundGradientColors: [Color] {
        agent.backgroundGradientColors.map { hexString in
            let cleanedHex = hexString.filter { "0123456789ABCDEFabcdef".contains($0) }
            let color = Color(hex: cleanedHex)
            
            if color != Color.white {
                print("Background Gradient Colors: \(hexString)")
                return color
            } else {
                print("Hata: Renk değeri geçersiz - \(hexString)")
                return Color.white
            }
        }
    }
    
    
    func agentImageView(url: URL?) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(let error):
                Text("Error loading image: \(error.localizedDescription)")
            @unknown default:
                EmptyView()
            }
        }
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false){
                
                GeometryReader { gr in
                    
                    ZStack {
                        agentImageView(url: URL(string: agent.background ?? ""))
                            .opacity(0.5)
                            .aspectRatio(contentMode: .fit)
                            .ignoresSafeArea()
                        
                        
                        
                        agentImageView(url: URL(string: agent.fullPortrait ?? ""))
                            .aspectRatio(contentMode: .fit)
                            .ignoresSafeArea()
                        
                        
                    }
                }//geometry reader bitiş
                .frame(height: 480)
                
                VStack(alignment: .center, spacing: 15) {
                    Text(agent.displayName)
                        .foregroundStyle(.red)
                        .font(.custom("VALORANT-Regular", size: 60))
                    Divider()
                        .frame(height: 2)
                        .background(.white)
                    Spacer()
                    if let role = agent.role {
                        Text(role.displayName.rawValue)
                            .bold()
                            .font(.custom("VALORANT-Regular", size: 40))
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 3)
                                
                            )
                        VStack(alignment: .leading, spacing: 10){
                            Text("//\(role.displayName.rawValue)")
                                .foregroundStyle(.red)
                                .font(.custom("VALORANT-Regular", size: 15))
                                .frame(alignment: .leading)
                            
                            Text(role.description)
                                .bold()
                                .padding([.leading, .trailing], 10)
                                .font(.title)
                                .foregroundStyle(.white)
                            Spacer()
                            Text("//BİOGRAPHY")
                                .foregroundStyle(.red)
                                .font(.custom("VALORANT-Regular", size: 15))
                                .frame(alignment: .leading)
                            
                            Text(agent.description)
                                .bold()
                                .padding([.leading, .trailing], 10)
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                    }
                    
                    
                    Spacer()
                    
                    ForEach(agent.abilities, id: \.self) { ability in
                        HStack {
                            
                            
                            
                            agentImageView(url: URL(string: ability.displayIcon ?? ""))
                                .background(LinearGradient(gradient: Gradient(colors: backgroundGradientColors), startPoint: .top, endPoint: .bottom))
                                .frame(width: 40, height: 40)
                            
                                .padding()
                            VStack {
                                
                                Text(ability.displayName)
                                    .bold()
                                    .foregroundColor(.red)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.custom("VALORANT-Regular", size: 30))
                                Text(ability.description)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                
                            }.background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                                
                            )
                            
                            Spacer()
                        }
                    }
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: backgroundGradientColors), startPoint: .top, endPoint: .bottom))
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "door.left.hand.open")
                        .foregroundStyle(.red)
                })
                
            }
        })
       
        .navigationBarBackButtonHidden(true)
    }
    
}
