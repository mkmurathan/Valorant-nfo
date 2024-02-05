//
//  settings.swift
//  ValorantWeapons
//
//  Created by Murathan karagöz on 2.02.2024.
//

import SwiftUI



struct settings: View {
   
    
    
    var body: some View {

       
                
            
            
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            VStack {
                
                Text("Settings")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 230))
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                
                Text("info")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 320))
                    .font(.title2)
                    .foregroundStyle(.gray)
                Spacer()
                
                    .navigationTitle("setting")
                
                
                HStack {
                    
                    Image("settingİmage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    
                    Text("This app was made by Murathan Karagöz.")
                        .foregroundStyle(.white)
                        .bold()
                    
                }//.padding(EdgeInsets(top: 0, leading: 0, bottom: 290, trailing: 70))
              
                HStack(spacing: 70){
                    
                    Text("version : 1.0")
                        .font(.title2)
                    // .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 240))
                        .foregroundStyle(.white)
                        .bold()
                    
                    
                    
                    Link("Follow on GitHub", destination: URL(string: "https://github.com/mkmurathan")!)
                    // .padding(EdgeInsets(top: 0, leading: 0, bottom: 170, trailing: 230))
                        .foregroundStyle(.blue)
                        .bold()
                    
                    
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 200, trailing: 0))
              
                VStack {
                   
                        Image("valorant")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(50)

                    
                }
                
            }
            
            
        }
        
        
        
    }
    
}



#Preview {
    settings()
}
