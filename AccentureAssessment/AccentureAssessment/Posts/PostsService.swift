//
//  PostsService.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 12/5/25.
//

import Foundation
import Alamofire
class PostsService {
    
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = Constants.ServiceUrl.kBaseURL
        AF.request(url)
            .validate()
            .responseDecodable(of: [Post].self) { response in
                switch response.result {
                case .success(let posts):
                    completion(.success(posts))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
