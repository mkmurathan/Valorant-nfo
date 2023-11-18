

import SwiftUI
import UIKit






struct WeaponDetailView: View {
    
    var weapon: Weapon.WeaponModel
    
    @StateObject var WeaponService = weaponService()
    @State private var selectedSkin: Skin? = nil
    @State private var isPopoverPresented: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    func weaponImageView(url: URL?) -> some View {
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
    
    struct CustomSlider: UIViewRepresentable {
        @Binding var value: Double
        var minValue: Double
        var maxValue: Double
        var thumbColor: Color
        var minTrackColor: Color
        var maxTrackColor: Color
        
        func makeUIView(context: Context) -> UISlider {
            let slider = UISlider()
            slider.minimumValue = Float(minValue)
            slider.maximumValue = Float(maxValue)
            slider.value = Float(value)
            slider.thumbTintColor = UIColor(thumbColor)
            slider.minimumTrackTintColor = UIColor(minTrackColor)
            slider.maximumTrackTintColor = UIColor(maxTrackColor)
            slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged), for: .valueChanged)
            return slider
        }
        
        func updateUIView(_ uiView: UISlider, context: Context) {
            uiView.value = Float(value)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(value: $value)
        }
        
        class Coordinator: NSObject {
            var value: Binding<Double>
            
            init(value: Binding<Double>) {
                self.value = value
            }
            
            @objc func valueChanged(_ sender: UISlider) {
                value.wrappedValue = Double(sender.value)
            }
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
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 15) {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(weapon.skins) { skin in
                                weaponImageView(url: URL(string: skin.displayIcon ?? ""))
                                    .scaledToFit()
                                    .frame(width: 180, height: 180)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .padding()
                                    .onTapGesture {
                                        selectedSkin = skin
                                        isPopoverPresented.toggle()
                                    }
                            }
                        }
                    }
                    .onTapGesture {
                        if let skin = selectedSkin {
                            isPopoverPresented.toggle()
                            selectedSkin = nil // Popover kapatıldığında seçilen cildi sıfırla
                        }
                    }
                    .popover(
                        isPresented: $isPopoverPresented,
                        content: {
                            if let skin = selectedSkin {
                                VStack {
                                    weaponImageView(url: URL(string: skin.displayIcon ?? ""))
                                        .scaledToFit()
                                        .frame(width: 400, height: 600) // İstediğiniz boyutu burada ayarlayabilirsiniz
                                        .padding()
                                    Spacer()
                                }.background(Color.black)
                            }
                        }
                    )
                    
                    
                    HStack {
                        Text(weapon.displayName)
                            .foregroundStyle(.red)
                        
                        
                        Text("-$\(weapon.shopData?.cost ?? 0)")
                            .foregroundStyle(.white)
                        
                    }.font(.custom("VALORANT-Regular", size: 30))
                    
                    Divider()
                        .frame(height: 2)
                        .background(.white)
                    
                    Spacer()
                    
                    Text("Category: \(getFormattedCategory(weapon.category))")
                        .font(.custom("VALORANT-Regular", size: 20))
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 3)
                        )
                    
                    
                    Spacer()
                    
                    if let weaponStats = weapon.weaponStats {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Weapon Stats:")
                                .font(.custom("VALORANT-Regular", size: 25))
                                .foregroundStyle(.red)
                            
                            
                            VStack {
                                
                                HStack {
                                    
                                    Text("Fire Rate:")
                                        .foregroundStyle(.white)
                                    
                                    Text("\(String(format: "%.2f", weaponStats.fireRate))")
                                    
                                }.font(.custom("VALORANT-Regular", size: 25))
                                
                                HStack {
                                    
                                    Text("0")
                                    CustomSlider(value: .constant(Double(weaponStats.fireRate)), minValue: 0, maxValue: 20, thumbColor: .clear, minTrackColor: .white, maxTrackColor: .gray)
                                    Text("50")
                                    
                                }.font(.custom("VALORANT-Regular", size: 20))
                                
                            }.padding()
                            
                            Text("Magazine Size: \(weaponStats.magazineSize)")
                                .font(.custom("VALORANT-Regular", size: 20))
                                .padding()
                            
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                    }
                    
                    Spacer()
                    
                    if let damageRanges = weapon.weaponStats?.damageRanges {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Damage Ranges:")
                                .font(.custom("VALORANT-Regular", size: 25))
                                .foregroundStyle(.red)
                            
                            ForEach(damageRanges, id: \.self) { damageRange in
                                
                                
                                VStack {
                                    Text("Range: \(damageRange.rangeStartMeters) - \(damageRange.rangeEndMeters)")
                                        .font(.custom("VALORANT-Regular", size: 20))
                                    HStack {
                                        Text("0")
                                        CustomSlider(value: .constant(Double(damageRange.rangeStartMeters)), minValue: 0, maxValue: 50, thumbColor: .clear, minTrackColor: .white, maxTrackColor: .gray)
                                        Text("50")
                                    }.font(.custom("VALORANT-Regular", size: 20))
                                }
                                
                                VStack {
                                    HStack {
                                        Text("Head Damage:")
                                            .foregroundStyle(.red)
                                        Text("\(String(format: "%.2f", damageRange.headDamage))")
                                        
                                    }.font(.custom("VALORANT-Regular", size: 20))
                                    
                                    HStack {
                                        Text("Body Damage:")
                                            .foregroundStyle(.red)
                                        Text("\(damageRange.bodyDamage)")
                                        
                                    }.font(.custom("VALORANT-Regular", size: 20))
                                    
                                    HStack {
                                        Text("Leg Damage:")
                                            .foregroundStyle(.red)
                                        Text("\(String(format: "%.2f", damageRange.legDamage))")
                                        
                                    }.font(.custom("VALORANT-Regular", size: 20))
                                    
                                }.padding()
                                
                            }
                            
                        }.foregroundStyle(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    
                    Spacer()
                    
                    
                    
                }
                .padding()
                
                
            }
            .background(Color.black)
            
        }.toolbar(content: {
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

struct WeaponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponDetailView(weapon: Weapon.WeaponModel(
            uuid: "123",
            displayName: "Example Weapon",
            category: "Rifle",
            displayIcon: "",
            killStreamIcon: "",
            assetPath: "",
            weaponStats: WeaponStats(
                fireRate: 9.0,
                magazineSize: 30,
                runSpeedMultiplier: 1.0,
                equipTimeSeconds: 1.5,
                reloadTimeSeconds: 2.0,
                firstBulletAccuracy: 0.9,
                shotgunPelletCount: 0,
                feature: nil,
                fireMode: nil,
                damageRanges: [
                    DamageRange(rangeStartMeters: 0, rangeEndMeters: 20, headDamage: 150.0, bodyDamage: 100, legDamage: 75.0),
                    DamageRange(rangeStartMeters: 20, rangeEndMeters: 50, headDamage: 140.0, bodyDamage: 90, legDamage: 70.0),
                    // Diğer DamageRange özelliklerini buraya ekleyebilirsiniz.
                ]
            ),
            shopData: nil, skins: []
        ))
    }
}
