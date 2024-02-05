




import SwiftUI

struct mapView: View {
    
    @StateObject private var viewModel = mapsViewModel()
    
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
    
    
    var body: some View {
      
        NavigationView {
            
            ZStack {
               
                VStack {
                   
                    Divider()
                        .background(Color.white)
                        .frame(height: 2)
                    
                    ScrollView(.vertical, showsIndicators: false ) {

                        VStack(spacing: 50) {
                            
                            ForEach(viewModel.maps) { maps in
                                
                                NavigationLink(destination: MapDetailMapView(maps : maps)) {
                                   
                                    ZStack {
                                        mapImageView(url: URL(string: maps.listViewIcon))
                                            .frame(width:380 ,height: 150)
                                            .cornerRadius(25.0)
                                            .shadow(radius: 10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25.0)
                                                    .stroke(Color.gray, lineWidth: 2)
                                            )
                                        
                                        Text(maps.displayName)
                                            .font(.custom("VALORANT-Regular", size: 27))
                                            .foregroundStyle(Color.red)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 95, trailing: 0))
                                    }  .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .scrollTransition(topLeading: .interactive, bottomTrailing: .interactive, axis: .vertical) { effect, phase in
                                            effect
                                                .scaleEffect(1 - abs(phase.value))
                                                .rotationEffect(.degrees(phase.value * 90 ))
                                        }
                                    
                                    
                                    
                                    
                                }
                                
                            }
                            
                        }
                        .background(Color.black)
                        
                        
                        
                        
                    }
                    .navigationBarItems(leading:
                                            HStack {
                        Text("MAPS")
                            .foregroundColor(.red)
                            .font(.custom("VALORANT-Regular", size: 35))
                    }
                    ).background(Color.black)
                  
                        .onAppear {
                        Task {
                            await viewModel.getMaps()  
                        }
                    }
             
                }
          
            }.background(Color.black)
            
        }.navigationBarHidden(false)
        
    }
    
}





#Preview {
    mapView()
}
