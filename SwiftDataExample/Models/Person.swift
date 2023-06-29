//
//  Person.swift
//  SwiftDataExample
//
//  Created by Mikhail Borisov on 29.06.2023.
//

import SwiftData
import Foundation

@Model
final class Person {

    @Attribute(.unique)
    var id: UUID
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    @Attribute(.externalStorage)
    var image: Data?
    @Relationship(deleteRule: .cascade)
    var relatives: [Person]

    init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        dateOfBirth: Date,
        relatives: [Person] = [],
        image: Data? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.relatives = relatives
        self.image = image
    }
}

extension Person {
    var fullName: String {
        return firstName + " " + lastName
    }
}
