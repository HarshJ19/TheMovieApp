//
//  MovieGenresListViewController.swift
//  TheMovieApp
//
//  Created by Harsh on 25/04/23.
//

import UIKit

class MovieGenresListViewController: UIViewController {
    
    @IBOutlet weak var movieGenresTable: UITableView!
    
    private var movieGenres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        movieGenresTable.delegate = self
        movieGenresTable.dataSource = self
        
        // Network connectivity check
        if Connectivity.isConnectedToInternet {
            fetchGenre()
        } else {
            AppManager.showAlert(strMsg: AppManager.alertMessages.NetworkUnreachable.rawValue, viewController: self)
        }
    }
    
    func fetchGenre() {
        APICaller.shared.getMovieGenres { result in
            switch result {
            case .success(let genres):
                self.movieGenres = genres
                DispatchQueue.main.async {
                    self.movieGenresTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension MovieGenresListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieGenres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieGenresTable.dequeueReusableCell(withIdentifier: MovieGenreTableViewCell.identifier) as? MovieGenreTableViewCell
        else { return UITableViewCell()}
        cell.lblMovieGenre.text = movieGenres[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesListVC = storyboard.instantiateViewController(withIdentifier: Constants.VC.MoviesListViewControllerIdentifier) as! MoviesListViewController
        moviesListVC.genreID = String(movieGenres[indexPath.row].id)
        self.navigationController?.pushViewController(moviesListVC, animated: true)
    }
    
}
