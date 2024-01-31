// WeaponMenu.swift



import SwiftUI

struct MenuButton: View {
    
    @Binding var selectedCategory: String?
    var categories: [String]
    var filterAction: (String) -> Void
    
    
    
    
    var body: some View {
     
                
        Menu(selectedCategory ?? "Select Category") {
            ForEach(categories, id: \.self) { category in
                Button(category) {
                    selectedCategory = category
                    filterAction(category)
                }
            }
        }
        .font(.custom("VALORANT-Regular", size: 15))
        
      
        
    }
    
}
