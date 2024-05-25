//
//  ArticleEntity+CoreDataProperties.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 25/05/24.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var createdAt: Date?

}

extension ArticleEntity : Identifiable {

}
