//
//  File.swift
//  qq
//
//  Created by Ivan Dimitrov on 23.01.21.
//

import Foundation
import MultipeerConnectivity

protocol ColorServiceDelegate {

    func connectedDevicesChanged(manager : ColorService, connectedDevices: [String])
    func colorChanged(manager : ColorService, dataModel: Data, peer : MCPeerID)

}

class ColorService : NSObject, ObservableObject {

    // Service type must be a unique string, at most 15 characters long
    // and can contain only ASCII lowercase letters, numbers and hyphens.
    
    @Published var peers: [MCPeerID] = []
    
    private let ColorServiceType = "ex"

    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser

    var delegate : ColorServiceDelegate?

    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()

    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ColorServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ColorServiceType)

        super.init()

        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()

        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
    }

    deinit {
        stopService()
    }
    func startService() {
        self.serviceAdvertiser.startAdvertisingPeer()
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    func stopService() {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    
    func send(data : Data) {

        if session.connectedPeers.count > 0 {
            do {
                try self.session.send( data , toPeers: session.connectedPeers, with: .reliable)
            }
            catch  {
            }
        }
    }
    
    func sendToFistPeer(data : Data, peerID : MCPeerID) {
     print("sendToFistPeer")
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(data, toPeers: [peerID], with: .reliable)
            }
            catch {print("no send")}
        }
    }
    
    func invitePeer(_ peerID: MCPeerID) {
      
        serviceBrowser.invitePeer( peerID, to: self.session, withContext: nil, timeout: 10)

    }


}

extension ColorService : MCNearbyServiceAdvertiserDelegate {

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {}

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, self.session)
    }

}

extension ColorService : MCNearbyServiceBrowserDelegate {

    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        peers.removeAll()
    }

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
       
//        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
//        invitePeer(peerID)
        
        if !peers.contains(peerID) {
            peers.append(peerID)
        }
        
        
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        guard  let index = peers.firstIndex(of: peerID) else { return }
        peers.remove(at: index)
    }

}

extension ColorService : MCSessionDelegate {

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
       
//        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
//            session.connectedPeers.map{$0.displayName})
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {

//        let str = String(data: data, encoding: .utf8)!
//        self.delegate?.colorChanged(manager: self, colorString: str)
          self.delegate?.colorChanged(manager: self, dataModel: data, peer: peerID)
        print("session")

    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}

}
