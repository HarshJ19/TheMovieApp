//
//  MovieReviewTableViewCell.swift
//  TheMovieApp
//
//  Created by Harsh on 26/04/23.
//

import UIKit

class MovieReviewTableViewCell: UITableViewCell {

    static let identifier = "MovieReviewTableViewCell"
    
    @IBOutlet var lblAuthor: UILabel!
    @IBOutlet var lblContent: UILabel!
    
    func configure(review: Review) {
        if let author = review.author {
            lblAuthor.text = author
        }
        if let content = review.content {
            lblContent.text = content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
