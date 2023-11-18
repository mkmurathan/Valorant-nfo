


import SwiftUI


struct TabBar: View {
    @State private var selectedIndex = 0
    
    var body: some View {
       
        TabView(selection: $selectedIndex) {
            
            mapView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("First Tab")
                }.tag(0)
            
            WeaponScroll()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second Tab")
                }.tag(1)
            
            agentScroll()
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Third Tab")
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
