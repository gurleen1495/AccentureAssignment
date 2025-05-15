//
//  PostsTableViewCell.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 12/5/25.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var postsTitle: UILabel!
    @IBOutlet weak var postsDesc: UILabel!
    @IBOutlet weak var imgFav: UIImageView!
    
    //MARK: Configure Cell
    func setData(post: Post) {
        self.postsTitle.text = post.title
        self.postsDesc.text = post.body
        if let isFav = post.isFavourite {
        if isFav{
            imgFav.isHidden = false
            imgFav.image = UIImage(systemName: Constants.Assets.kStar)
        } else{
            imgFav.isHidden = true
        }
        } else {
            imgFav.isHidden = true
        }
    }

}
