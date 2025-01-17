//
//  modelData.swift
//  myclock
//
//  Created by  玉城 on 2024/4/22.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Codable,Identifiable {
    var id: Int
//    var name: String
//    var themeBackgroundColor: String
//    var themeBgSecondColor: String
//    var themeTextColor: String
//    var startPoint: CGPoint
//    var endPoint:  CGPoint
    var colors : [String]
    var liked : Bool
//    var startPoint: CGPoint
//    var endPoint: CGPoint
}



//@Observable
class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("gradients.json")
    @Published var landmarks2: [Landmark] = load("gradients2.json")
    
//    init(landmarks : [Landmark]) {
//        self.landmarks = landmarks
//    }
}



func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

