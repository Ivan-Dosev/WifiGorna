//
//  DataView.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 17.01.21.
//

import SwiftUI
import CryptoKit

struct DataView: View {
    
    @Environment(\.presentationMode) var pMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CryptoData_Array.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CryptoData_Array.data_event, ascending: true)]) var cryptoDataArray: FetchedResults<CryptoData_Array>
    
    var height : CGFloat {
        let a = UIScreen.main.bounds.width
        if a < 700 {
            return 70
        }else{
            return 140
        }
    }
    @State var agreem : String = ""
    @State var publik : String = ""
    @State var arda :[Int] = [ 2 , 1 , 2 , 1 , 0 , 0, 1 , 2, 2]
    @State var gray     = UIColor(red: 0.4  , green: 0.4  , blue: 0.4  , alpha: 1)
    @State var grayTop = UIColor(red: 0.718, green: 0.718, blue: 0.718, alpha: 1)
    
    @State var pickerNumber : Int = 2
    @State var textSearch : String = ""
    @State var isTapGesture : Bool = false
    @State var color : [UIColor] = [UIColor(red: 0.8, green: 0.1, blue: 0.5, alpha: 1),UIColor(red: 0.0, green: 0.991, blue: 1.0, alpha: 1),UIColor(red: 0.999, green: 0.986, blue: 0.0, alpha: 1),UIColor(red: 0.582, green: 0.216, blue: 1.0, alpha: 1)]
    
    @Binding var image : UIImage?

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
                               
                    }) {
                        Text("⚙️")
                            .font(.system(size: 17))
                            .frame(width: UIScreen.main.bounds.width / 4 , height: 50, alignment: .center)
                            .modifier(PrimaryButton())
                    }
                    Spacer()
                    Button(action: {
                                          self.save()
                    }) {
                        Text("⇪")
                            .font(.system(size: 17))
                            .frame(width: UIScreen.main.bounds.width / 4 , height: 50, alignment: .center)
                            .modifier(PrimaryButton())
                    }
                }
                .offset(y: 10)
                .frame(width: UIScreen.main.bounds.width / 1.1 ,  height: 100, alignment: .center)
               
                
                VStack {
                    ZStack{
                        
                        TextField("Search ...", text: $textSearch)
                         .textFieldStyle(RoundedBorderTextFieldStyle())
                        if self.textSearch != "" {
                            
                          
                                Button(action: {
                                        self.textSearch = ""
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("✕")
                                            .padding(.horizontal, 5)
                                            .overlay(RoundedRectangle(cornerRadius: 2).stroke(lineWidth: 1).foregroundColor(.gray))
                                            .foregroundColor(.gray)
                                           
                                    } .padding()
                                }
                            
                        }
                    } .frame(width: UIScreen.main.bounds.width / 1.1, alignment: .center)
                }   .frame(width: UIScreen.main.bounds.width / 1.1 ,  height: 50, alignment: .center)
               
                
                VStack {
                    Picker(selection: $pickerNumber, label: Text("")) {
                        Text("  All  ").tag(0)
                        Text("Received").tag(1)
                        Text("Observer").tag(2)
                        Text("  Send  ").tag(3)
                    }.pickerStyle(SegmentedPickerStyle())
                     .frame(width: UIScreen.main.bounds.width / 1.1, alignment: .center)
                }
                
//               $0.index_F?.contains(String(self.pickerNumber)) as! Bool
//                ForEach( cryptoDataArray.filter{$0.index_F?.contains(String(self.pickerNumber)) as! Bool} , id:\.name_Title) { index in
                Spacer()
    VStack {
        if pickerNumber == 0 {
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
                        ForEach(Array(zip(cryptoDataArray.indices ,cryptoDataArray )), id:\.0) { ( number , index ) in
                            BlockView(number: number, crypto: index)
                                .onTapGesture {
                                    deleteItem(indexSet: number)
                                }
                 
        //                        .offset(y: -11)
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
        //            } .offset(y: -71)
                }
            }
        }else{
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
                        ForEach(Array(zip(cryptoDataArray.indices ,cryptoDataArray.filter{$0.index_F?.contains(String(self.pickerNumber)) as! Bool})),id:\.0) { ( number , index ) in
                            BlockView(number: number, crypto: index)
                            .onTapGesture {
                                if index.index_F == "1" {
                                    let receiverEncryptionKey  = try! Curve25519.KeyAgreement.PrivateKey(rawRepresentation: index.key_agreement!)
                                    let senderSigningPublicKey =   try! Curve25519.Signing.PublicKey(rawRepresentation: index.key_public!)
                                    let decryptedMessage = try? decrypt( index.crypt_Date!, using: receiverEncryptionKey, from: senderSigningPublicKey)
                                    image = UIImage(data: decryptedMessage!)
                                    pMode.wrappedValue.dismiss()
                                }else{
                                    if index.index_F == "3" {
                                        image = UIImage(data: index.crypt_Date!)
                                        pMode.wrappedValue.dismiss()
                                    }else{
                                        image = UIImage(named: "Ok")
                                        pMode.wrappedValue.dismiss()
                                    }
                                }

//                            if index.key_agreement!.isEmpty {
//                                self.agreem = "not key_agreement"
//                            }else{
//                                self.agreem = "yes key_agreement"
//                            }
//                            if index.key_public!.isEmpty {
//                                self.publik = "not key_public"
//                            }else{
//                                self.publik = "yes key_public"
//                            }
                        }
                      
        //                        .offset(y: -11)
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
        //            } .offset(y: -71)
                }
            }
        }
              
                
                
//                VStack {
//                    if pickerNumber == 0 {
//                        List{
//                            ForEach(  cryptoDataArray , id:\.name_Title) { index in
//                                ZStack{
//                                    ZStack{
//                                        HStack(spacing: 0) {
//
//                                            RoundedRectangle(cornerRadius: 7)
//                                                .frame(width: CGFloat("\(index.name_Title!)".count) * 12, height: 30, alignment: .center)
//                                                .overlay(Color.yellow.cornerRadius(7, antialiased: true))
//                                            RoundedRectangle(cornerRadius: 7)
//                                                .frame(width:  50, height: 30, alignment: .center)
//                                                .overlay(Color.yellow.cornerRadius(7, antialiased: true).opacity(0.7))
//                                            Spacer()
//                                        }
//
//                                        HStack{
//                                            Text("\(index.name_Title!)")
//                                                .foregroundColor(.white)
//                                                .offset(x: 2)
//                                            Spacer()
//                                        }
//
//                                    }
//
////                                    HStack {
////                                        Text("\(index.name_Title!)")
////                                            .foregroundColor(.gray)
////
////                                        Text("\(index.index_F!)")
////                                            .foregroundColor(.red)
////
////                                    }
//
//                                }
//
//                            }.onDelete(perform: deleteItem)
//                        }.environment(\.defaultMinListRowHeight, 20)
//                    }
//                    else{
//                        VStack(spacing: 0){
//                            Text("")
//                            ForEach( Array(zip(cryptoDataArray.indices, cryptoDataArray.filter{$0.index_F?.contains(String(self.pickerNumber)) as! Bool})),id:\.0 ) {( number ,index ) in
////                            ForEach( Array(zip(cryptoDataArray.indices, cryptoDataArray)),id:\.0 ) {( number ,index ) in
////                            ForEach(  cryptoDataArray.filter{$0.index_F?.contains(String(self.pickerNumber)) as! Bool} , id:\.name_Title) { index in
//                                ZStack{
//                                    HStack(spacing: 0) {
//                                        RoundedRectangle(cornerRadius: 12)
//                                            .frame(width:  50, height: 50, alignment: .center)
//                                            .overlay(Color(color.randomElement()!).cornerRadius(12, antialiased: true).opacity(0.7))
//                                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).foregroundColor(.gray))
//                                        RoundedRectangle(cornerRadius: 12)
//                                            .frame(width: CGFloat("\(index.name_Title!)    ".count) * 12, height: 50, alignment: .center)
//                                            .overlay(Color.yellow.cornerRadius(7, antialiased: true))
//                                            .overlay(RoundedRectangle(cornerRadius: 7).stroke(lineWidth: 2).foregroundColor(.gray))
//
//
//
//                                        Spacer()
//                                    }.padding(.horizontal, 10)
//
//                                    HStack{
//                                        Text("\(index.name_Title!)")
//                                            .foregroundColor(.white)
//                                            .offset(x: 55)
//                                        Spacer()
//                                    }.padding(.horizontal, 10)
//
//                                }
//                                .onTapGesture {
//                                    image = UIImage(data: index.crypt_Date!)
//                                    pMode.wrappedValue.dismiss()
//                                }
//                            }
//                            Spacer()
//                        }
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height - 300, alignment: .center)
//                .modifier(PrimaryButton())
            }
                Text("agreem: \(agreem)")
                Text("publik: \(publik)")
        }
    }
}
    
    func save() {
        let imageToData = UIImage(named: "Ok")
        let data = imageToData?.jpegData(compressionQuality: 1.0)
        
        let textData = CryptoData_Array(context: moc)
        textData.name_Title = self.textSearch
        textData.index_F   = String( Int.random(in: 1..<4))
        
        textData.crypt_Date = data

        do {
            try self.moc.save()
        }catch {}
    }
    
//    func saveA() {
//        let imageToData = UIImage(named: "png1")
//        let data = imageToData?.jpegData(compressionQuality: 1.0)
//
//        let textData = CryptoData_Array(context: moc)
//        textData.name_Title = self.textSearch
//        textData.index_F   = String( Int.random(in: 1..<4))
//
//        textData.crypt_Date = data
//
//        do {
//            try self.moc.save()
//        }catch {
//
//        }
//    }
    
    func deleteItem(indexSet: Int) {
        let deleteItem = self.cryptoDataArray[indexSet]
                         self.moc.delete(deleteItem)
        
        do{ try! self.moc.save() }
    }
    
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
//        DataView()
        Text("")
    }
}
