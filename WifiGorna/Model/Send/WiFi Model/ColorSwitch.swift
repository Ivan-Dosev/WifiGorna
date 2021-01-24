//
//  ColorSwitch.swift
//  qq
//
//  Created by Ivan Dimitrov on 23.01.21.
//


import UIKit
import SwiftUI
import MultipeerConnectivity
import CryptoKit


extension SendView : ColorServiceDelegate {

    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
//            self.text = "Connections: \(connectedDevices)"
        }
    }
 
    func colorChanged(manager: ColorService, dataModel: Data, peer : MCPeerID) {
//        OperationQueue.main.addOperation {
//
//            let textData = CryptoData_Array(context: moc)
//                textData.name_Title = peer.displayName
//                textData.crypt_Date = dataModel
//                textData.index_F   = String( Int.random(in: 1..<4))
//            do {
//                try self.moc.save()
//            }catch {}
//            
//            self.isOk = true
//            self.peerString = peer.displayName
//            print("\(dataModel)")
////            image = UIImage(data: dataModel)!
//            ardaImage = Image(uiImage:  UIImage(data: dataModel)!)
////            self.text =  String(decoding: dataModel, as: UTF8.self)
//
//        }
        
        OperationQueue.main.addOperation {

            let dataFromModel = try! JSONDecoder().decode(Model.self, from: dataModel)


                if !dataFromModel.peerID.isEmpty {

                    if dataFromModel.isSender {

                        self.signingID = String(decoding: dataFromModel.peerID, as: UTF8.self)
                          colorService.sendToFistPeer(data: keyAgreenentPublic(), peerID: peer)
//                        colorService.send(colorName: keyAgreenentPublic())
                    }else {
                        self.agreementID =  String(decoding: dataFromModel.peerID, as: UTF8.self)
//                        send data
                          colorService.send(data: senderData())
                          saveToCoreData()
                    }
                }

                if !dataFromModel.massige.isEmpty {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MMM dd, yyyy"
//                    self.selectedDateText = formatter.string(from: self.dateNow)
                    
                    let textData = CryptoData_Array(context: moc)
                        textData.name_Title = peer.displayName
                        textData.crypt_Date = dataFromModel.massige
                        textData.data_event = formatter.string(from: self.dateNow)
                        textData.date_term = formatter.string(from: self.dateFutuer)
                    if   self.signingID == "" {
                        textData.index_F   = String(2)
                    }else{
                        textData.index_F   = String(1)
                    }
                      
                    do {
                             try self.moc.save()
                    }catch {}
                    
                    self.isOk = true
                    self.peerString = peer.displayName
                    print("\(dataModel)")
       
                    ardaImage = Image(uiImage:  UIImage(data: dataFromModel.massige)!)
       

                }

        }
    }
    func change(color : Data) {
//        self.numberID = String(decoding: color, as: UTF8.self)
    }
}


struct Model   :  Codable {
   
   var peerID   : Data
   var massige  : Data
   var isSender : Bool
}
