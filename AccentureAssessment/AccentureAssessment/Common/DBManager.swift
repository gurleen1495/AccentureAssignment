//
//  DBManager.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 12/5/25.
//

import Foundation
import RealmSwift
import Network

class DBManager {

    private let realm = try! Realm()

    func savePost(posts: [Post]) {
        let postObjects = posts.map { PostObject(from: $0) }
        
        try! realm.write {
            realm.add(postObjects, update: .modified)
        }
    }
    
    func updatePostForFavourite(id: Int, isFav: Bool) {
        if let post = realm.object(ofType: PostObject.self, forPrimaryKey: id) {
            try? realm.write {
                post.isFavourite = isFav
            }
        }
    }
    
    func fetchPosts() -> [Post] {
        let realmPosts = realm.objects(PostObject.self)
        let posts: [Post] = realmPosts.map { Post(from: $0) }
        return posts
    }

    // Delete a single post
    func deletePost(post: PostObject) {
        try? realm.write {
            realm.delete(post)
        }
    }
    
    func fetchPostsForFavourites() -> Results<PostObject> {
        return realm.objects(PostObject.self).filter("isFavourite == true")
    }
    
    func updatePostsPreservingFavorites(with newPosts: [Post]) {
        let existing = realm.objects(PostObject.self)
        let favouriteMap = Dictionary(uniqueKeysWithValues: existing.map { ($0.id, $0.isFavourite) })
        
        let merged: [PostObject] = newPosts.map { post in
            var p = post
            if let fav = favouriteMap[post.id] {
                p.isFavourite = fav
            }
            return PostObject(from: p)
        }
        try! realm.write {
            realm.add(merged, update: .modified)
        }
    }
}

class PostObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var isFavourite: Bool = false
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension PostObject {
    convenience init(from post: Post) {
        self.init()
        self.id = post.id
        self.userId = post.userId
        self.title = post.title
        self.body = post.body
        self.isFavourite = post.isFavourite ?? false
    }
}
