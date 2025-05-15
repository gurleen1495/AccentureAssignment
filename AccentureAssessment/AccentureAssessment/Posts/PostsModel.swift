//
//  PostsModel.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 12/5/25.
//

import Foundation
struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    var isFavourite: Bool?
    
    init(from object: PostObject) {
        self.id = object.id
        self.userId = object.userId
        self.title = object.title
        self.body = object.body
        self.isFavourite = object.isFavourite
    }
}

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.body == rhs.body &&
        lhs.userId == rhs.userId &&
        lhs.isFavourite == rhs.isFavourite
    }
}
