//
//  MoviesListViewController.swift
//  TheMovieApp
//
//  Created by Harsh on 25/04/23.
//

import UIKit

class MoviesListViewController: UIViewController {

    @IBOutlet weak var moviesTable: UITableView!
    
    var movies = [Movie]()
    var totalPages = 0
    var currentPage = 1
    var genreID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //moviesTable.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        
        moviesTable.register(UINib(nibName: MoviesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MoviesTableViewCell.identifier)

        moviesTable.delegate = self
        moviesTable.dataSource = self
        
        // Network connectivity check
        if Connectivity.isConnectedToInternet {
            // First list of movies as soon as reached on this view
            fetchMovies(pageNumber: self.currentPage)
        } else {
            AppManager.showAlert(strMsg: AppManager.alertMessages.NetworkUnreachable.rawValue, viewController: self)
        }
        
    }
    
    func fetchMovies(pageNumber : Int) {
        APICaller.shared.getMoviesForGenre(genreId: genreID, pageNumber: self.currentPage ) { result in
            switch result {
            case .success(let fetchedMovies):
                self.movies.append(contentsOf: fetchedMovies.results)
                self.currentPage = fetchedMovies.page + 1
                self.totalPages = fetchedMovies.total_pages
                DispatchQueue.main.async {
                    self.moviesTable.reloadData()
                }
            case .failure(let error):
                print("Fail to get data");
                print(error.localizedDescription)
            }
        }
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = moviesTable.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier) as? MoviesTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configure(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesInfoVC = storyboard.instantiateViewController(withIdentifier: Constants.VC.MovieInfoViewControllerIdentifier) as! MovieInfoViewController
        moviesInfoVC.movieID = String(movies[indexPath.row].id)
        moviesInfoVC.movieTitle = String(movies[indexPath.row].title)
        self.navigationController?.pushViewController(moviesInfoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        //let movies = movies[indexPath.row]
        if(indexPath.row == self.movies.count-1){
            if(self.currentPage <= self.totalPages){
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                spinner.startAnimating()
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.fetchMovies(pageNumber: self.currentPage)
                }
            }
        else{
                tableView.tableFooterView?.removeFromSuperview()
                let view = UIView()
                view.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(5))
                tableView.tableFooterView = view
                tableView.tableFooterView?.isHidden = true
            }
        }
        else{
            tableView.tableFooterView?.removeFromSuperview()
            let view = UIView()
            view.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(5))
            tableView.tableFooterView = view
            tableView.tableFooterView?.isHidden = true
        }
    }
    
}
