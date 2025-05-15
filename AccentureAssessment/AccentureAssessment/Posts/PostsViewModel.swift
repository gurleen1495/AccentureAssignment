//
//  PostsViewModel.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 12/5/25.
//

import Foundation
import RealmSwift
class PostsViewModel {

    private var posts: [Post] = []
    private let service = PostsService()

    var onPostsFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    func numberOfPosts() -> Int {
        return posts.count
    }

    func post(at index: Int) -> Post {
        return posts[index]
    }
    
    func updatePost(at index: Int, isFav: Bool){
        posts[index].isFavourite = isFav
    }
    
    func savePostsToDB(posts: [Post]) {
        let manager = DBManager()
        manager.updatePostsPreservingFavorites(with: posts)
    }
    
    func fetchRealmPosts() {
        let manager = DBManager()
        let offlinePosts = manager.fetchPosts()
        self.posts = offlinePosts
    }
    
    func fetchLaunchPosts() {
        let manager = DBManager()
        let offlinePosts = manager.fetchPosts()
        self.posts = offlinePosts
        DispatchQueue.global(qos: .background).async {
            self.service.fetchPosts { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let onlinePosts):
                        if offlinePosts != onlinePosts {
                            self?.savePostsToDB(posts: onlinePosts)
                            self?.posts = manager.fetchPosts()
                            self?.onPostsFetched?()
                        }
                    case .failure(let error):
                        self?.onError?(error.localizedDescription)
                    }
                }
            }
        }
    }
}
