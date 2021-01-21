//
//  ForView.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 19.01.21.
//

import SwiftUI

struct ForView: View {
    @Binding var new : UIImage
    @Binding var number   : Int
             var numbeR   : Int
             var index    : CryptoData_Array
    
    
    var body: some View {
        HStack {
            Spacer()
            Text("\(index.name_Title!)")
                .foregroundColor(.gray)
             
            Text("\(index.index_F!)")
                .foregroundColor(.red)
            Text("\(number)")
                .foregroundColor(.blue)
            Spacer()
             
        }
        .scaleEffect(self.number == numbeR ? 2 : 1)
        .onTapGesture {
            self.number = numbeR
            print("qqqqq")
        }
    }
}


