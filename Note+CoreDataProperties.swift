//
//  Note+CoreDataProperties.swift
//  NotesCFT
//
//  Created by Дмитрий Геращенко on 30.09.2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var noteText: String?
    @NSManaged public var date: Date?

}

extension Note : Identifiable {

}
