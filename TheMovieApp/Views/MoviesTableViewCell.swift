//
//  MoviesTableViewCell.swift
//  TheMovieApp
//
//  Created by Harsh on 25/04/23.
//

import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {

    static let identifier = "MoviesTableViewCell"
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var lblMovieTitle: UILabel!
    @IBOutlet var lblReleaseDate: UILabel!
    
    func configure(movie: Movie) {
        lblMovieTitle.text = movie.title
        lblReleaseDate.text = movie.release_date
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)") else {
            return
        }
        moviePoster.sd_setImage(with: url, completed: nil)
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
