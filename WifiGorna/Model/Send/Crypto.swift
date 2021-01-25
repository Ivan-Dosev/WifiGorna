//
//  Crypto.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 25.01.21.
//

import CryptoKit
import SwiftUI


    
    let secretKey = "bvcxz"
    let message    =  "arda 111 varda 222".data(using: .utf8)
    
    // create sender Sign Key
    let senderSigningKey = Curve25519.Signing.PrivateKey()
    let senderSigningPublicKey = senderSigningKey.publicKey
    
    
    // create receiver Sign Key
    let receiverEncryptionKey = Curve25519.KeyAgreement.PrivateKey()
    let receiverEncryptionPublicKey = receiverEncryptionKey.publicKey
    
    
    
//    let sealedMessage = try! encrypt(message, to: receiverEncryptionPublicKey, signedBy: senderSigningKey)
    
    
//    let decryptedMessage = try? decrypt(sealedMessage, using: receiverEncryptionKey, from: senderSigningPublicKey)
    
//    print(“The following message was successfully decrypted: \(String(data: decryptedMessage!, encoding: .utf8)!)”)

    
    
    
    func encryptArda(_ data: Data, to theirEncryptionKey: Curve25519.KeyAgreement.PublicKey, signedBy ourSigningKey: Curve25519.Signing.PrivateKey) throws -> Data {
    // Create a salt for key derivation.
    let protocolSalt = secretKey.data(using: .utf8)!
    let ephemeralKey = Curve25519.KeyAgreement.PrivateKey()
    let ephemeralPublicKey = ephemeralKey.publicKey.rawRepresentation
    let sharedSecret = try ephemeralKey.sharedSecretFromKeyAgreement(with: theirEncryptionKey)
    let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
    salt:              protocolSalt,
    sharedInfo:        ephemeralPublicKey +
    theirEncryptionKey.rawRepresentation + ourSigningKey.publicKey.rawRepresentation,
    outputByteCount:   32)
    let ciphertext = try ChaChaPoly.seal(data, using: symmetricKey).combined
    let signature = try ourSigningKey.signature(for: ciphertext + ephemeralPublicKey + theirEncryptionKey.rawRepresentation)
    let encode = Mara(ephmeralPublicKeyData: ephemeralPublicKey, ciphertext: ciphertext, signature: signature)
    let encodeData = try! JSONEncoder().encode(encode)
    return encodeData
    }
    
    
    func decrypt(_ sealedMessage: (ephmeralPublicKeyData: Data, ciphertext: Data, signature: Data),
    using ourKeyEncryptionKey: Curve25519.KeyAgreement.PrivateKey,
    from theirSigningKey: Curve25519.Signing.PublicKey) throws -> Data {
    // Create a salt for key derivation.
    let protocolSalt = secretKey.data(using: .utf8)!
    let ephemeralKey = try Curve25519.KeyAgreement.PublicKey(rawRepresentation: sealedMessage.ephmeralPublicKeyData)
    let sharedSecret = try ourKeyEncryptionKey.sharedSecretFromKeyAgreement(with: ephemeralKey)
    let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
    salt:              protocolSalt,
    sharedInfo:        ephemeralKey.rawRepresentation + ourKeyEncryptionKey.publicKey.rawRepresentation + theirSigningKey.rawRepresentation,
    outputByteCount:   32)
    let sealedBox = try ChaChaPoly.SealedBox(combined: sealedMessage.ciphertext)
    return try ChaChaPoly.open(sealedBox, using: symmetricKey)
    }


/*
 let sealedMessage = try! encryptArda(message!, to: receiverEncryptionPublicKey , signedBy: senderSigningKey)

     let decryptedMessage = try? decrypt(sealedMessage, using: receiverEncryptionKey, from: senderSigningPublicKey)
     print(">>:\(String(data: decryptedMessage!, encoding: .utf8)!)")
 //    print(“The following message was successfully decrypted: \(String(data: decryptedMessage!, encoding: .utf8)!)”)
 */
struct Mara: Codable  {
    var ephmeralPublicKeyData: Data
    var ciphertext           : Data
    var signature            : Data
}
