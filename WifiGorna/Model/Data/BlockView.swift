//
//  BlockView.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 21.01.21.
//

import SwiftUI

struct BlockView: View {
    
    var height : CGFloat {
        let a = UIScreen.main.bounds.width
        if a < 700 {
            return 70
        }else{
            return 140
        }
    }
    
    var number : Int  // poreden nomer v spisaka
    var crypto : CryptoData_Array
    var index  : Int  {
        guard  let i = Int( crypto.index_F!) else {return 0 }
        return     i
    } // [0,1,2] izprateno , polucheno , svidetel
 
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
                    .fill(index == 3 ? Color(gray0) : index == 1 ? Color(gray1) : Color(gray2))
                    .frame(width: UIScreen.main.bounds.width / 4.1 , height: height)
                    .overlay(Block().stroke(lineWidth: height == 140 ? 5 : 2).foregroundColor(Color(gray)))
                    .padding(.horizontal, 20)
                Spacer()
            }

            HStack{

                Image("klu\(index)")
                    .resizable()
                    .offset(x: 40)
//                    .frame(width:  50, height: 50)
                    .frame(width: index == 1 ? 50 : 30, height: index == 1 ? 50 : 40)
                Text("\(crypto.name_Title!)")
                    .fontWeight(.bold)
                    .foregroundColor(index == 3 ? .white : .black)
                    .offset(x: index == 1 ? 50 : 70)
                Spacer()
                VStack{
                    Text("[ \(crypto.data_event!) ]   ")
                        .offset(x: -20)
                        .font(.custom("", size: 12))
                    Text("[ \(crypto.date_term!) ]   ")
                        .font(.custom("", size: 12))
                        .offset(x: -20)
                }
            }
            
        }
    }
}


struct Block : Shape {
    
    func path(in rect: CGRect) -> Path {
        let deltaX = rect.maxX / 10
        let deltaY = rect.maxY / 8
        var path = Path()
            path.move(   to: CGPoint(x: rect.minX, y: deltaY ))
            path.addLine(to: CGPoint(x: deltaX   , y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 4, y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 5, y: deltaY))
            path.addLine(to: CGPoint(x: deltaX * 7, y: deltaY))
            path.addLine(to: CGPoint(x: deltaX * 8, y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 36, y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 37, y: deltaY))
            path.addLine(to: CGPoint(x: deltaX * 37, y: deltaY * 6 ))
            path.addLine(to: CGPoint(x: deltaX * 36, y: deltaY * 7))
            path.addLine(to: CGPoint(x: deltaX * 8, y: deltaY * 7))
            path.addLine(to: CGPoint(x: deltaX * 7, y: deltaY * 8))
            path.addLine(to: CGPoint(x: deltaX * 5, y: deltaY * 8))
            path.addLine(to: CGPoint(x: deltaX * 4, y: deltaY * 7))
            path.addLine(to: CGPoint(x: deltaX    , y: deltaY * 7))
            path.addLine(to: CGPoint(x: rect.minX    , y: deltaY * 6))
            path.addLine(to: CGPoint(x: rect.minX    , y: deltaY ))
        
        
        
        return path
    }
}

struct BlockTop : Shape {
    
    func path(in rect: CGRect) -> Path {
        let deltaX = rect.maxX / 10
        let deltaY = rect.maxY / 8
        var path = Path()
            path.move(   to: CGPoint(x: rect.minX, y: deltaY ))
            path.addLine(to: CGPoint(x: deltaX   , y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 36, y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 37, y: deltaY))
            path.addLine(to: CGPoint(x: deltaX * 37, y: deltaY * 6 ))
            path.addLine(to: CGPoint(x: deltaX * 36, y: deltaY * 7))
            path.addLine(to: CGPoint(x: deltaX * 8, y: deltaY * 7))
            path.addLine(to: CGPoint(x: deltaX * 7, y: deltaY * 8))
            path.addLine(to: CGPoint(x: deltaX * 5, y: deltaY * 8))
            path.addLine(to: CGPoint(x: deltaX * 4, y: deltaY * 7))
            path.addLine(to: CGPoint(x: deltaX    , y: deltaY * 7))
            path.addLine(to: CGPoint(x: rect.minX    , y: deltaY * 6))
            path.addLine(to: CGPoint(x: rect.minX    , y: deltaY ))
        
        
        
        return path
    }
}

struct BlockBottom : Shape {
    
    func path(in rect: CGRect) -> Path {
        let deltaX = rect.maxX / 10
        let deltaY = rect.maxY / 8
        var path = Path()
            path.move(   to: CGPoint(x: rect.minX, y: deltaY ))
            path.addLine(to: CGPoint(x: deltaX   , y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 4, y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 5, y: deltaY))
            path.addLine(to: CGPoint(x: deltaX * 7, y: deltaY))
            path.addLine(to: CGPoint(x: deltaX * 8, y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 36, y: rect.minY))
            path.addLine(to: CGPoint(x: deltaX * 37, y: deltaY))
            path.addLine(to: CGPoint(x: deltaX * 37, y: deltaY * 6 ))
            path.addLine(to: CGPoint(x: deltaX * 36, y: deltaY * 7))
            path.addLine(to: CGPoint(x: deltaX    , y: deltaY * 7))
            path.addLine(to: CGPoint(x: rect.minX    , y: deltaY * 6))
            path.addLine(to: CGPoint(x: rect.minX    , y: deltaY ))
        
        
        
        return path
    }
}
