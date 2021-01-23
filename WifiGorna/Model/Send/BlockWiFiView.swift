//
//  BlockWiFiView.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 21.01.21.
//

import SwiftUI
import MultipeerConnectivity

struct BlockWiFiView: View {
    
    var peer : MCPeerID
    
    var height : CGFloat {
        let a = UIScreen.main.bounds.width
        if a < 700 {
            return 70
        }else{
            return 140
        }
    }
    @State var gray  = UIColor(red: 0.4  , green: 0.4  , blue: 0.4  , alpha: 1)
    @State var gray1 = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
//    cherven
//    @State var gray2  = UIColor(red: 1  , green: 1  , blue: 1  , alpha: 1)
//    @State var gray2  = UIColor(red: 0.957  , green: 0.8  , blue: 0.8  , alpha: 1)
    @State var gray2  = UIColor(red: 1  , green: 0.796  , blue: 0.643  , alpha: 1)
    
//  zelen
//    @State var gray0  = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
//      @State var gray0  = UIColor(red: 0.851, green: 0.918, blue: 0.827, alpha: 1)
    @State var gray0  = UIColor(red: 0.678, green: 0.663, blue: 0.431, alpha: 1)
    
    var body: some View {
        
        
        
        ZStack {
            HStack {
                Block()
                    .fill(Color(gray0))
                    .frame(width: UIScreen.main.bounds.width / 4.1 , height: height)
                    .overlay(Block().stroke(lineWidth: height == 140 ? 5 : 2).foregroundColor(Color(gray)))
                    .padding(.horizontal, 20)
                Spacer()
            }
            HStack{
                
                    Text(peer.displayName)
                
            }
        }
    }
}

