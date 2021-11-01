//
//  Repository+CoreDataProperties.swift
//  GHKanban
//
//  Created by Diego on 31/10/21.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var name: String?
    @NSManaged public var author: String?
    @NSManaged public var idNum: Int32
    @NSManaged public var issue: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    public var wrappedAuthor: String {
        author ?? "Anonymous author"
    }
    public var issues: [Issue] {
        let set = issue as? Set<Issue> ?? []
        
        return set.sorted {
            $0.wrappedTitle < $1.wrappedTitle
        }
    }

}

// MARK: Generated accessors for issue
extension Repository {

    @objc(addIssueObject:)
    @NSManaged public func addToIssue(_ value: Issue)

    @objc(removeIssueObject:)
    @NSManaged public func removeFromIssue(_ value: Issue)

    @objc(addIssue:)
    @NSManaged public func addToIssue(_ values: NSSet)

    @objc(removeIssue:)
    @NSManaged public func removeFromIssue(_ values: NSSet)

}

extension Repository : Identifiable {

}
