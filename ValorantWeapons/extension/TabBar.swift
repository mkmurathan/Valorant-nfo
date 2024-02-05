


import SwiftUI


struct TabBar: View {
    @State private var selectedIndex = 0
    
    var body: some View {
       
        TabView(selection: $selectedIndex) {
            
            mapView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("MAPS")
                }.tag(0)
            
            WeaponScroll()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("WEAPONS")
                }.tag(1)
            
            agentScroll()
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("AGENTS")
                }.tag(2)
            
            settings()
                .tabItem {
                    Image(systemName: "4.circle")
                    Text("SETTİNGS")
                }.tag(2)
            
            
        } .accentColor(Color.red) // Seçilen tab için renk
                        .onAppear {
                            UITabBar.appearance().barTintColor = .black // Tab bar arkaplan rengi
                            UITabBar.appearance().unselectedItemTintColor = .white
            
        }
        
    }
    
}

#Preview {
    TabBar()
}
