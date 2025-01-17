//
//  MainView.swift
//  Gradient
//
//  Created by  玉城 on 2024/5/1.
//

import SwiftUI
//import CoreLocation
//import Foundation

struct MainView: View {
//    @EnvironmentObject var modelData: ModelData
//    @Environment(ModelData.self) var modelData
    @StateObject var modelData = ModelData()
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element }
    }
    var filteredLandmarks2: [Landmark] {
        modelData.landmarks.enumerated().filter { $0.offset % 2 != 0 }.map { $0.element }
    }

    init() {

    }
    
    var body: some View {
//        NavigationView {
        ZStack{
           
//                Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40)
                
            ScrollView {
                
                LazyVStack(spacing: 15) {
                    
                    HStack(alignment: .top,spacing: 15){
                        VStack(alignment: .leading, spacing: 15){
                            ForEach(filteredLandmarks) { landmark in
                                GradientCard(gradient:landmark)
                                    .cornerRadius(15)
                                    .frame(width:(UIScreen.main.bounds.width - 45) / 2, height: 300).foregroundColor(.red)
                                
                            }
                            
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 15){
                            ForEach(filteredLandmarks2) { landmark in
                                GradientCard(gradient:landmark)
                                    .cornerRadius(15)
                                    .frame(width:(UIScreen.main.bounds.width - 45) / 2, height: landmark.id == 1 ? 400 : 300).foregroundColor(.blue)
                            }
                            
                        }
                    }
                    
                    
                }
                .padding(.horizontal, 10)
            }
            .padding()
            .edgesIgnoringSafeArea(.bottom)
       

        }
        
    }
//    }
    
}

struct GradientCard: View {
    var gradient: Landmark
    
    func hexToColor(hex: String, alpha: Double = 1.0) -> Color {
        var formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        
        let scanner = Scanner(string: formattedHex)
        var color: UInt64 = 0
        
        if scanner.scanHexInt64(&color) {
            let red = Double((color & 0xFF0000) >> 16) / 255.0
            let green = Double((color & 0x00FF00) >> 8) / 255.0
            let blue = Double(color & 0x0000FF) / 255.0
            return Color(red: red, green: green, blue: blue, opacity: alpha)
        } else {
            // 返回默认颜色，当转换失败时
            return Color.black
        }
    }
    
    
    var body: some View {
        
//        NavigationLink(destination: GradientView(liked: gradient.liked,color1:gradient.colors[0],color2:gradient.colors[1]))
        NavigationLink(destination: GradientView(gradient:gradient))
        {
            LinearGradient(gradient: Gradient(colors: [ hexToColor(hex:gradient.colors[0]), hexToColor(hex:gradient.colors[1])]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x:0.5, y: 1))
        }
     

    }
}



//
//#Preview {
////    MainView().environment(ModelData())
//}
