//
//  splashScreenView.swift
//  ValorantWeapons
//
//  Created by Murathan karagöz on 1.02.2024.
//

import SwiftUI

struct splashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
  
    
    var body: some View {
      
        if isActive {
            TabBar()
        } else {
            
             ZStack {
                 Color.black.ignoresSafeArea()
               
                 VStack {
                     
                     VStack {
                         Image("launchİmage")
                             .resizable()
                             .scaledToFit()
                             .font(.system(size: 30))
                 
                         Text("Valorant APP")
                             .font(.custom("VALORANT-Regular", size: 30))
                             .foregroundStyle(.red.opacity(0.80))
                             
                     }
                     .scaleEffect(size)
                     .opacity(opacity)
                     .onAppear {
                         withAnimation(.easeIn(duration: 1.2)) {
                             self.size = 0.9
                             self.opacity = 1.0
                         }
                     }
                     
                 }.background(Color.black)
                 .onAppear {
                     DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                         withAnimation {
                             self.isActive = true
                         }
                         
                     }
          
                 }
           
             }
        }
        
       
        
        
    }
    
}

#Preview {
    splashScreenView()
}
