//
//  ReviewsViewController.swift
//  TheMovieApp
//
//  Created by Harsh on 26/04/23.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    @IBOutlet weak var reviewsTable: UITableView!
    
    var reviews = [Review]()
    var totalPages = 0
    var currentPage = 1
    var movieID = String()
    var movieTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        reviewsTable.delegate = self
        reviewsTable.dataSource = self
        
        // Network connectivity check
        if Connectivity.isConnectedToInternet {
            // First list of movies as soon as reached on this view
            fetchReviews(pageNumber: self.currentPage)
        } else {
            AppManager.showAlert(strMsg: AppManager.alertMessages.NetworkUnreachable.rawValue, viewController: self)
        }
    }
    
    func handleNoReviews() {
        if reviews.count == 0 {
            AppManager.showAlert(strMsg: AppManager.alertMessages.NoReviews.rawValue, viewController: self)
        }
    }
    
    func fetchReviews(pageNumber: Int) {
        APICaller.shared.getReviews(movieId: movieID, pageNumber: self.currentPage) { result in
            switch result {
            case .success(let fetchedReviews):
                self.reviews.append(contentsOf: fetchedReviews.results)
                self.currentPage = fetchedReviews.page + 1
                self.totalPages = fetchedReviews.total_pages
                DispatchQueue.main.async {
                    self.reviewsTable.reloadData()
                }
                self.handleNoReviews()
            case .failure(let error):
                print("Fail to get data");
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reviewsTable.dequeueReusableCell(withIdentifier: MovieReviewTableViewCell.identifier) as? MovieReviewTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configure(review: reviews[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        //let movies = movies[indexPath.row]
        if(indexPath.row == self.reviews.count-1){
            if(self.currentPage <= self.totalPages){
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                spinner.startAnimating()
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.fetchReviews(pageNumber: self.currentPage)
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
