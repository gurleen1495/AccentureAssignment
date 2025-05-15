//
//  FavouritesViewModel.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 13/5/25.
//

import Foundation
import RealmSwift

class FavouritesViewModel {

    //MARK: Variables
    private var favPosts: [Post] = []

    var onPostsFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    //MARK: Functions
    func numberOfPosts() -> Int {
        return favPosts.count
    }

    func post(at index: Int) -> Post {
        return favPosts[index]
    }
    
    func fetchFavouritePosts(){
        let manager = DBManager()
        let realmPosts: Results<PostObject> = manager.fetchPostsForFavourites()
        let posts: [Post] = realmPosts.map { Post(from: $0) }
        favPosts = posts
    }
}
