//
//  CryptoData_Array+CoreDataProperties.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 19.01.21.
//
//

import Foundation
import CoreData


extension CryptoData_Array {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CryptoData_Array> {
        return NSFetchRequest<CryptoData_Array>(entityName: "CryptoData_Array")
    }

    @NSManaged public var crypt_Date: Data?
    @NSManaged public var crypt_Witness: Data?
    @NSManaged public var data_event: String?
    @NSManaged public var date_term: String?
    @NSManaged public var index_F: String?
    @NSManaged public var is_key: Bool
    @NSManaged public var key_agreement: Data?
    @NSManaged public var key_public: Data?
    @NSManaged public var name_Title: String?

}

extension CryptoData_Array : Identifiable {

}
