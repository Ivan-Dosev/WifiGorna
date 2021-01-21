//
//  Button.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 17.01.21.
//

import Foundation
import SwiftUI


struct PrimaryButton: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)

                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(.white)
                        .blur(radius: 4.0)
                        .offset(x: -8.0, y: -8.0) })

            .foregroundColor(.gray)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 20, x: 20.0  , y:  20.0)
            .shadow(color: Color.white, radius: 20, x: -20.0 , y: -20.0)

    }
}


