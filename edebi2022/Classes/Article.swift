//
//  Article.swift
//  edebi2022
//
//  Created by George Tevosov on 19.02.2022.
//

import Foundation
import CoreData

extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var content: String?
    @NSManaged public var creation_date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var language: String?
    @NSManaged public var modification_date: Date?
    @NSManaged public var title: String?
    
    override public var description: String {
        return "\(title ?? "") \(content ?? "")"
    }
}
