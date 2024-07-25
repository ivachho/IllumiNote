//
//  User Performance Metrics+CoreDataProperties.swift
//  IllumiNote
//
//  Created by Iva Chho on 7/24/24.
//
//

import Foundation
import CoreData


extension User Performance Metrics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User Performance Metrics> {
        return NSFetchRequest<User Performance Metrics>(entityName: "UserPerformance")
    }

    @NSManaged public var sessionId: Int64
    @NSManaged public var dateTime: Date?
    @NSManaged public var song: String?
    @NSManaged public var noteAccuracy: Float
    @NSManaged public var rhythmAccuracy: Float
    @NSManaged public var tempoAccuracy: Float

}

extension User Performance Metrics : Identifiable {

}
