//
//  Issue+CoreDataProperties.swift
//  GHKanban
//
//  Created by Diego on 31/10/21.
//
//

import Foundation
import CoreData


extension Issue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Issue> {
        return NSFetchRequest<Issue>(entityName: "Issue")
    }

    @NSManaged public var title: String?
    @NSManaged public var info: String?
    @NSManaged public var position: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var parentRepository: Repository?
    
    public var wrappedTitle: String {
        title ?? "Unknown title"
    }
    public var wrappedInfo: String { 
        info ?? "Empty info"
    }
    public var wrappedPosition: IssuePosition {
        get {
            IssuePosition(rawValue: Int(position)) ?? .backlog
        }
        set {
            position = Int32(newValue.rawValue)
        }
    }

}

extension Issue : Identifiable {

}
