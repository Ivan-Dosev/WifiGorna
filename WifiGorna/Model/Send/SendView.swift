//
//  SendView.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 17.01.21.
//

import SwiftUI
import CryptoKit
import MultipeerConnectivity

struct SendView: View {
    
    @ObservedObject var colorService = ColorService()
    @State var peerString : String = ""
    @Binding var image : UIImage?
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CryptoData_Array.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CryptoData_Array.data_event, ascending: true)]) var cryptoDataArray: FetchedResults<CryptoData_Array>
    
    @Environment(\.presentationMode) var pMode
    @State var grayTop = UIColor(red: 0.718, green: 0.718, blue: 0.718, alpha: 1)
    @State var gray  = UIColor(red: 0.4  , green: 0.4  , blue: 0.4  , alpha: 1)
    @State var gray1 = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)

    @State var gray2  = UIColor(red: 1  , green: 0.796  , blue: 0.643  , alpha: 1)

    @State var gray0  = UIColor(red: 0.678, green: 0.663, blue: 0.431, alpha: 1)
    
    var height : CGFloat {
        let a = UIScreen.main.bounds.width
        if a < 700 {
            return 70
        }else{
            return 140
        }
    }
    
    var privateID_Key : Curve25519.Signing.PrivateKey {
     
         if let data = UserDefaults.standard.data(forKey: "PrivateKey") {
             
               return try! Curve25519.Signing.PrivateKey(rawRepresentation: data)
             
         }else{
               let kay = Curve25519.Signing.PrivateKey()
                         UserDefaults.standard.set( kay.rawRepresentation, forKey: "PrivateKey")
            return kay
         }
     }
     var privateAgreement_Key : Curve25519.KeyAgreement.PrivateKey {
         if let data = UserDefaults.standard.data(forKey: "AgreementKey") {
             
             return try! Curve25519.KeyAgreement.PrivateKey(rawRepresentation: data)
             
         }else{
             let kay = Curve25519.KeyAgreement.PrivateKey()
                         UserDefaults.standard.set( kay.rawRepresentation, forKey: "AgreementKey")
            return kay
         }
     }
    
    @State var signingID       : String = ""
    @State var agreementID     : String = ""
  
    
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
                                if isOk && self.peerString == peer.displayName{
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

//                                        let data = image?.jpegData(compressionQuality: 1.0)
                                        self.signingID = ""
                                        self.agreementID = ""
                                        
                                          colorService.sendToFistPeer(data: senderSigningPublic(), peerID: peer)
//                                        colorService.sendToFistPeer(data: data!, peerID: peer)
//                                        colorService.send(data: data!)
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
                Text("signingID :\(signingID )")
                    .onTapGesture {
                        self.signingID = ""
                    }
                Text("agreementID  :\(agreementID  )")
                    .onTapGesture {
                        self.agreementID = ""
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
    
    func senderSigningPublic() -> Data {
        let model = Model(peerID: privateID_Key.publicKey.rawRepresentation, massige: Data(),isSender: true)
        let modelData = try! JSONEncoder().encode(model)
       return modelData
    }
    
    func keyAgreenentPublic() -> Data {
        let model = Model(peerID: privateAgreement_Key.publicKey.rawRepresentation, massige: Data(),isSender: false)
        let modelData = try! JSONEncoder().encode(model)
       return modelData
    }
    
    func senderData() -> Data {
        
        let data = image?.jpegData(compressionQuality: 1.0)
        
        let model = Model(peerID: Data(), massige: data!, isSender: true)
        
        let modelData = try! JSONEncoder().encode(model)
       return modelData
    }
    func saveToCoreData() {
        let data = image?.jpegData(compressionQuality: 1.0)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
//                    self.selectedDateText = formatter.string(from: self.dateNow)
        
        let textData = CryptoData_Array(context: moc)
            textData.name_Title = "My Phone Send"
            textData.crypt_Date = data
            textData.data_event = formatter.string(from: self.dateNow)
            textData.date_term = formatter.string(from: self.dateFutuer)
            textData.index_F   = String(3)

          
        do {
                 try self.moc.save()
        }catch {}
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
