//
//  mapDetailView.swift
//  ValorantWeapons
//
//  Created by Murathan karagöz on 26.01.2024.
//

import SwiftUI

struct MapDetailMapView: View {
    
    var maps: mapler.mapModel
    
    func mapImageView(url: URL?) -> some View {
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
    
    @Environment(\.dismiss) private var dismiss

    
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
              
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 10) {
                      
                        ZStack {
                            mapImageView(url: URL(string: maps.splash))
                                .frame(width: 395, height: 220)
                            
                            if maps.coordinates != nil {
                                Text(maps.coordinates ?? "")
                                    .font(.system(size: 17))
                                    .foregroundStyle(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(EdgeInsets(top: 160, leading: 20, bottom: 0, trailing: 0))
                            } else {
                                
                            }
                           
                        }
                     
                        Spacer()
                      
                        Text(maps.displayName)
                            .foregroundStyle(.red)
                            .font(.largeTitle)
                            .bold()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            .underline(true, color: Color.white)
                       
                       
                        Text(maps.narrativeDescription ?? "")
                            .foregroundStyle(.white)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .font(.title3)
                            .bold()
                        
                        Spacer()
                        
                        Text("Type of sites on map")
                            .foregroundStyle(.red)
                            .bold()
                            .font(.title2)
                        
                        Text(maps.tacticalDescription ?? "")
                            .foregroundStyle(.white)
                        
                        Spacer()
                      
                       
                       
                        ZStack{
                          
                            mapImageView(url: URL(string: maps.displayIcon ?? ""))
                                .scaledToFit()
                            
                            Text("Tactical view")
                                .padding(EdgeInsets(top: 0, leading: 200, bottom: 350, trailing: 20))
                                .font(.title2)
                                .foregroundStyle(.red)
                            
                        }
                        
                        
                    }
               
                }
           
            }.background(Color.black)
            
        } 
        .navigationBarItems(leading:
                                HStack {
            
            Text("MAPS")
                .foregroundColor(.red)
                .font(.custom("VALORANT-Regular", size: 35))
                .padding(EdgeInsets(top: 0, leading: 83, bottom: 0, trailing: 0))
        }
        )
        
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

#Preview {
    MapDetailMapView(maps: mapler.mapModel(uuid: "7eaecc1b-4337-bbf6-6ab9-04b8f06b3319", displayName: "ASCENT", narrativeDescription: "An open playground for small wars of position and attrition divide two sites on Ascent. Each site can be fortified by irreversible bomb doors; once they’re down, you’ll have to destroy them or find another way. Yield as little territory as possible.", tacticalDescription: "A/B Sites", coordinates: "45°26'BF'N,12°20'Q'E", displayIcon: "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/displayicon.png", listViewIcon: "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/listviewicon.png", listViewIconTall: "", splash: "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/splash.png", stylizedBackgroundImage: "", premierBackgroundImage: "", assetPath: "", xMultiplier: 10.2, yMultiplier: 10.2, xScalarToAdd: 10.2, yScalarToAdd: 10.2))
}
