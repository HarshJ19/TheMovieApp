//
//  MovieGenreTableViewCell.swift
//  TheMovieApp
//
//  Created by Harsh on 26/04/23.
//

import UIKit

class MovieGenreTableViewCell: UITableViewCell {

    static let identifier = "MovieGenreTableViewCell"
    
    @IBOutlet var lblMovieGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
