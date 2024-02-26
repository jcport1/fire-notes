//
//  Note.swift
//  HW7
//
//  Created by Jefferson Cuartas on 10/31/23.
//

import Foundation

// MARK: - Welcome
struct NoteIfo: Codable {
    let notes: [Note]
}

// MARK: - Note
struct Note: Codable {
    let id: String
    let userID: String
    let text: String?
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case text
        case v = "__v"
    }
}

