//
//  FavouritesTableViewCell.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 13/5/25.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var favPostsTitle: UILabel!
    @IBOutlet weak var favPostsDesc: UILabel!
    
    //MARK: Cell data
    func configure(post: Post) {
        self.favPostsTitle.text = post.title
        self.favPostsDesc.text = post.body
    }

}
