//
//  GradientView.swift
//  Gradient
//
//  Created by  玉城 on 2024/5/2.
//

import SwiftUI
import PhotosUI

struct Toast: View {
    let message: String
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .transition(.move(edge: .bottom))
    }
}

struct GradientView: View {
//    @EnvironmentObject var modelData: ModelData
    @StateObject var modelData = ModelData()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showToast: Bool = false
    @State private var showToast1: Bool = false
    @State private var showToast2: Bool = false
    @State private var showTime: Bool = false
    @State private var showLike: Bool = false
    @State var clickCount = UserDefaults.standard.integer(forKey: "clickCount519")
    //    @State var color1: String
    //    @State var color2: String
    @State var gradient: Landmark
    @AppStorage("isPurchased") var isPurchased: Bool = false
    @State private var currentDate: Int?
    
    
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == gradient.id })!
    }
    
    
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
    
    var ImageView: some View {
        LinearGradient(gradient: Gradient(colors:[ hexToColor(hex:gradient.colors[0]) , hexToColor(hex:gradient.colors[1]) ]), startPoint: .top, endPoint: .bottom)
        //        LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
        
    }
    
    var textView: some View {
        Text("Hello, SwiftUI")
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
    
    
    func getCurrentDateNumber() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: Date())
        let month = components.month ?? 0
        let day = components.day ?? 0
        return month * 100 + day
    }

    func saveCurrentDate() {
        currentDate = getCurrentDateNumber()
      
        UserDefaults.standard.set(currentDate, forKey: "currentDate")
    }

    func loadCurrentDate() {
        currentDate = UserDefaults.standard.integer(forKey: "currentDate")
      
    }
    
    
    
    var body: some View {
        @StateObject var modelData = ModelData()
//        @ObservedObject var modelData: ModelData()
        ZStack {
            ImageView
            if showTime {
                VStack{
                    Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    TimeView()
                    Spacer()
                } }
            
            VStack{
                
                Spacer()
//                Text("\( getCurrentDateNumber() )")
//                Text("按钮点击次数：\(clickCount)")
                HStack(spacing: 40){
                    Image(systemName: "arrow.down.circle.fill")
                        .onTapGesture {
                            if !isPurchased {
                                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "clickCount\(getCurrentDateNumber())") + 1, forKey: "clickCount\(getCurrentDateNumber())")
                            }
                            // isPurchased
                            if UserDefaults.standard.integer(forKey: "clickCount\(getCurrentDateNumber())") <= 5 || isPurchased {
                               // Button("Save Achievment") {
                               let renderer = ImageRenderer(content: ImageView)
                               if let image = renderer.uiImage {
                                   let imageSaver = ImageSever()
                                   imageSaver.writeToPhotoAlbum(image: image)
                                   //                                        }
                               }
                               showToast = true
                               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                   showToast = false
                               }
                               
                               
                           } else {
                               showToast1 = true
                               DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                   showToast1 = false
                               }
                               // 按钮点击次数大于5，显示toast提示开通pro
//                               Toast(message: "saved!")
                           }
            
                            
                        
                            
                            // 添加点击事件处理代码，例如显示一个提示
                            // print("Image tapped!")
                        }.opacity(0.4).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                    Image(systemName: "eye.circle.fill")
                        .onTapGesture {
                            showTime.toggle()
                        }.opacity(0.4).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                    
//                    LikeView(isSet: $modelData.landmarks[landmarkIndex].liked)
                } .foregroundColor(.white)
                    .font(.system(size: 50)).padding(.bottom,100)
                
                //                    .shadow(color: Color.white.opacity(0.5), radius: 10, x: 0, y: 2)
                
            }
            if showToast {
                
                Toast(message: "saved!")
                
            }
            if showToast1 {
                
                Toast(message: "Limit downloads to 5 times per day. exceeding the limit requires Pro")
                
            }
            if showToast2 {
                Toast(message: "Successfully added collection")
            }
            
            VStack{
                Spacer().frame(height: 40)
                HStack(alignment: .center,spacing:20){
                    
                    Image(systemName:"chevron.backward")
                        .fontWeight(.bold)
                        .opacity(0.6)
                        .padding(.leading,20)
                        .padding(.top,20)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }.shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                    
                    Spacer()
                    
                }
                Spacer()
                
            }
            
        }
        .navigationBarHidden(true)
        .foregroundColor(Color.white)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}


class ImageSever: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved!")
    }
}




//#Preview {
//    let modelData = ModelData()
//    return GradientView(gradient: modelData.landmarks[0])
//        .environment(modelData)
//}


struct TimeView: View {
    @State private var currentTime: String = ""
    
    var body: some View {
        VStack {
            Text(currentTime)
                .font(.system(size: 80))
                .padding()
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
        }
        .onAppear {
            updateTime()
        }
        
    }
    
    func updateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        currentTime = formatter.string(from: Date())
    }
}
