//
//  MovieInfoViewController.swift
//  TheMovieApp
//
//  Created by Harsh on 25/04/23.
//

import UIKit
import SDWebImage

class MovieInfoViewController: UIViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    @IBOutlet weak var lblMovieStatus: UILabel!
    @IBOutlet weak var lblMovieVotes: UILabel!
    
    var movieID = String()
    var movieTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Network connectivity check
        if Connectivity.isConnectedToInternet {
            fetchMovieInfo()
        } else {
            AppManager.showAlert(strMsg: AppManager.alertMessages.NetworkUnreachable.rawValue, viewController: self)
        }
    }
    
    @IBAction func showReviews() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesReviewsVC = storyboard.instantiateViewController(withIdentifier: Constants.VC.ReviewsViewControllerIdentifier) as! ReviewsViewController
        moviesReviewsVC.movieID = movieID
        moviesReviewsVC.movieTitle = movieTitle
        self.navigationController?.pushViewController(moviesReviewsVC, animated: true)
    }
    
    func setValues(model: MovieInfoResponse){
        guard let url = URL(string: (Constants.baseImageURL)+(model.poster_path ?? ""))
        else {
            return
        }
        moviePoster.sd_setImage(with: url, completed: nil)
        if let title = model.original_title {
            lblMovieTitle.text = title
            movieTitle = title
        }
        if let overview = model.overview {
            lblMovieOverview.text = overview
        }
        if let status =  model.status {
            lblMovieStatus.text = status
        }
        if let vote = model.vote_count {
            lblMovieVotes.text = String(vote)
        }
    }
    
    func fetchMovieInfo()
    {
        APICaller.shared.getMoviesInfo(movieId: movieID, completion: { result in
            switch result {
            case .success(let fetchedMovies):
                DispatchQueue.main.async {
                    self.setValues(model: fetchedMovies)
                }
                print(fetchedMovies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
