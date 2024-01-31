


import SwiftUI


struct WeaponScroll: View {
    
    @StateObject var weaponViewModel = WeaponViewModel()
    @State private var selectedCategory: String?
    
    func weaponImageView(url: URL?) -> some View {
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
       
       func getFormattedCategory(_ category: String) -> String {
           let components = category.components(separatedBy: "::")
           if let lastComponent = components.last {
               return lastComponent
           }
           return category
       }
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack {
                
                VStack {
                    
                    HStack {
                        MenuButton(selectedCategory: $selectedCategory, categories: ["All", "Rifle", "Shotgun", "Sidearm", "Sniper", "SMG", "Melee"]) { category in
                            selectedCategory = category
                            weaponViewModel.filterWeaponsByCategory(category)
                        }
                    }.buttonStyle(CustomButtonStyle(isSelected: selectedCategory != nil))
                        .padding(.trailing, 300)
                    
                                        
                    
                    Divider()
                        .background(Color.white)
                        .frame(height: 2)
                    
                    ScrollView (.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                            
                            ForEach(weaponViewModel.filteredWeapons) { weapon in
                                
                                NavigationLink(destination: WeaponDetailView(weapon: weapon)) {
                                    
                                    VStack (spacing: 10) {
                                        
                                        weaponImageView(url: URL(string: weapon.displayIcon))
                                            .scaledToFit()
                                            .frame(width:150 ,height: 150)
                                            .cornerRadius(25.0)
                                            .shadow(radius: 10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25.0)
                                                    .stroke(Color.gray, lineWidth: 2)
                                            ).padding([.leading, .trailing], 15)
                                        
                                        HStack {
                                            
                                            Text("\(weapon.displayName) //")
                                                .font(.custom("VALORANT-Regular", size: 15))
                                                .foregroundStyle(Color.red)
                                            
                                            
                                            
                                            Text("\(getFormattedCategory(weapon.category))")
                                                .font(.custom("VALORANT-Regular", size: 10))
                                                .foregroundStyle(.gray)
                                            
                                        }
                                        
                                    }
                                    .padding()
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .scrollTransition(topLeading: .interactive, bottomTrailing: .interactive, axis: .vertical) { effect, phase in
                                        effect
                                            .scaleEffect(1 - abs(phase.value))
                                            .rotationEffect(.degrees(phase.value * 90 ))
                                    }
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                    }.backgroundStyle(Color.black) // scrollview bitişi
                        
                }
                .onAppear {
                    weaponViewModel.getWeapons()
                }
            }
            .background(Color.black)
            .navigationBarItems(leading:
                                    HStack {
                Text("WEAPONS")
                    .foregroundColor(.red)
                    .font(.custom("VALORANT-Regular", size: 35))
            }
            )
        }.background(Color.black)
    }
}

struct WeaponScroll_Previews: PreviewProvider {
    static var previews: some View {
        WeaponScroll()
    }
}
