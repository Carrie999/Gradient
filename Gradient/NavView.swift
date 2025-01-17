//
//  NavView.swift
//  Gradient
//
//  Created by  玉城 on 2024/5/2.
//

import SwiftUI

struct NavView: View {
//    @Environment(ModelData.self) var modelData
//    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            VStack {
                MainView()
            }
            .navigationBarTitle("Gradient")
           
            .navigationBarItems(trailing:
                HStack {
//                    NavigationLink(destination: SettingView()) {
//                        Image(systemName: "person")
//                    }
//                    NavigationLink(destination: Text("Notifications")) {
//                        Image(systemName: "plus")
//                    }
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "gearshape")
                    }
            }
            .foregroundColor(DataColor.hexToColor(hex:"#595959"))

            )
//            .toolbarBackground(
//                
//                // 1
//                DataColor.hexToColor(hex:"#b7e281"),
//                // 2
//                for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
            
        }.navigationViewStyle(StackNavigationViewStyle())
       
    }
}


//#Preview {
////    NavView().environmentObject(ModelData.landmarks)
//}
