//
//  SendView.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 17.01.21.
//

import SwiftUI

struct SendView: View {
    
    @ObservedObject var colorService = ColorService()
    @Binding var image : UIImage?
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CryptoData_Array.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CryptoData_Array.data_event, ascending: true)]) var cryptoDataArray: FetchedResults<CryptoData_Array>
    
    @Environment(\.presentationMode) var pMode
    @State var grayTop = UIColor(red: 0.718, green: 0.718, blue: 0.718, alpha: 1)
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
    
    var height : CGFloat {
        let a = UIScreen.main.bounds.width
        if a < 700 {
            return 70
        }else{
            return 140
        }
    }
    
    @State var dateNow    : Date = Date()
    @State var dateFutuer : Date = Date()
    @State var selectedDateText : String = ""
    @State var text : String = ""
    @State var isOnOffSend : Bool = false
    @State var isOk        : Bool = false
    @State var ardaImage : Image = Image("png1")
    
    var body: some View {
        
        
        ZStack {
            Color.gray.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack{
                    Button(action: {
                            pMode.wrappedValue.dismiss()
                    }) {
                        Text("⏎")
                            .font(.system(size: 17))
                            .frame(width: UIScreen.main.bounds.width / 4 , height: 50, alignment: .center)
                            .modifier(PrimaryButton())
                    }
                    Spacer()

                    Button(action: {
                            self.isOnOffSend.toggle()
                    }) {
                        HStack {
                            Text("Send")
                                .font(.system(size: 17))
                            Text( isOnOffSend ? "🔵" : "🔘")
                                .font(.system(size: 17))

                        }
                        .frame(width: UIScreen.main.bounds.width / 4 , height: 50, alignment: .center)
                        .modifier(PrimaryButton())
                    }
                }
                .offset(y: 10)
                .frame(width: UIScreen.main.bounds.width / 1.1 ,  height: 100, alignment: .center)
                
                
                
                VStack(spacing: 5){
                    HStack{
                        Text("Current date")
                            .font(.custom("", size: 12))
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("Validity period")
                            .font(.custom("", size: 12))
                            .padding(.horizontal, 20)
                   
                    }

                    HStack{
                        Text("\(selectedDateText)")
                            .padding(.horizontal, 10)
                        Spacer()
                        DatePicker(selection: $dateNow, in: Date()... , displayedComponents: .date) {}
                            .padding(.horizontal, 10)
                   
                        
                    }
                    Text("Select a validity period longer than the current date")
                        .font(.custom("", size: 12))
                   
                }
                .frame(width: UIScreen.main.bounds.width / 1.1 ,  height: 100, alignment: .center)
                .modifier(PrimaryButton())
                
                
                Spacer()
                
                ScrollView(.vertical) {
                    VStack(spacing: height == 140 ? -17 : -9) {
                        ZStack {
                            HStack{
                            BlockTop()
                                .fill(Color(grayTop))
                                .frame(width: UIScreen.main.bounds.width / 4.1 , height: height)
                                .overlay(BlockTop().stroke(lineWidth: height == 140 ? 5 : 2).foregroundColor(Color(gray)))
                                .padding(.horizontal, 20)
                            Spacer()
                            }
                            HStack{
                                Text("BLOCK's")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
//                        for
                        
                        ForEach(colorService.peers, id:\.self) { peer in
                            ZStack{
                                BlockWiFiView(peer: peer)
                                    .onAppear(){
                                        self.colorService.delegate = self
                                        colorService.invitePeer(peer)
                                    }
                                if isOk {
                                    HStack{
                                        Image("klu1")
                                            .resizable()
                                            .offset(x: 40)
                                            .frame(width:  50 , height:  50 )
                                        Spacer()
                                    }
                                }
                                
                                
                                if self.isOnOffSend {
                                    Button(action: {
//                                        let imageToData = UIImage(named: "Ok")
                                        let data = image?.jpegData(compressionQuality: 1.0)
//                                        let data = "arda varda 1111".data(using: .utf8)
    //                                    colorService.send(colorName: data!)
                                        colorService.sendToFistPeer(data: data!, peerID: peer)
                                        print("tap ..")
                                        
                                    }) {
                                        HStack {
                                            Spacer()
                                            Text(" 🐱 ")
                                                .padding()
                                                .frame(width: height , height: height * 0.5, alignment: .center)
                                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(lineWidth: 1).foregroundColor(Color(gray)))
                                                .offset(x: -height / 2)
                                        }
                                    }
                                }
//  end if
                            }

                        }
                        
                        
                        ZStack {
                            HStack{
                                BlockBottom()
                                    .fill(Color(grayTop))
                                    .frame(width: UIScreen.main.bounds.width / 4.1 , height: height)
                                    .overlay(BlockBottom().stroke(lineWidth: height == 140 ? 5 : 2).foregroundColor(Color(gray)))
                                    .padding(.horizontal, 20)
                                Spacer()
                            }
                            HStack{
                                Text("E N D")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        
                    }
                    
                }
//                Text("arda - \(text)")
//                 ardaImage
//                    .resizable()
//                    .frame(width: 100, height: 100, alignment: .center)
            }.onAppear(){
                setDateString()
            }
            .onDisappear(){
                colorService.stopService()
            }
          
        }
    }
    private func setDateString() {
      let formatter = DateFormatter()
      formatter.dateFormat = "MMM dd, yyyy"
      self.selectedDateText = formatter.string(from: self.dateNow)
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
//        SendView()
          Text("")
    }
}
