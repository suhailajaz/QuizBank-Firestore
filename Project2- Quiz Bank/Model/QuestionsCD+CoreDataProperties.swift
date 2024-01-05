//
//  QuestionsCD+CoreDataProperties.swift
//  
//
//  Created by suhail on 09/10/23.
//
//

import Foundation
import CoreData


extension QuestionsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionsCD> {
        return NSFetchRequest<QuestionsCD>(entityName: "QuestionsCD")
    }

    @NSManaged public var text: String?
    @NSManaged public var answer: String?

}
