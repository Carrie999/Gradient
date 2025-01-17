//
//  LikeView.swift
//  Gradient
//
//  Created by  玉城 on 2024/5/3.
//

import SwiftUI

struct LikeView: View {
    @Binding var isSet: Bool
    var body: some View {
        Image(systemName: "heart.circle.fill")
            .onTapGesture {
                isSet.toggle()
            } 
            .foregroundColor(.white)
            .opacity( isSet ? 0.7 : 0.4)
    }
}

#Preview {
    LikeView(isSet: .constant(true))
}
