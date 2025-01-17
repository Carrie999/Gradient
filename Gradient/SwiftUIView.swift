//
//  SwiftUIView.swift
//  Gradient
//
//  Created by  玉城 on 2024/5/3.
//

import SwiftUI


#Preview {
    SwiftUIView()
}


struct SwiftUIView: View {
    var body: some View {
        
        ZStack{
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        }
          
            Text("Visit Singapore")
                  .padding()
                  .background(.thinMaterial)
        }
        
//         .animation(.easeInOut(duration: 2))
        }
  
}
