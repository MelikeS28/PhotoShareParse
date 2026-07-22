//
//  FeedViewController.swift
//  parseTemplate
//
//  Created by Melike on 3.04.2025.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let viewModel = FeedViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.delegate = self
        viewModel.fetchPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchDataNotification), name: NSNotification.Name(rawValue: "newPOST"), object: nil)
    }
    
    @objc func fetchDataNotification(){
        viewModel.fetchPosts()
    }
        
    // MARK: - TableView DataSource and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewTableViewCell
        
        let post = viewModel.posts[indexPath.row]
        
        cell.userNameLabel.text = post.userName
        cell.commentLabel.text = post.userComment
        
        post.userImage.getDataInBackground { data, error in
            if error == nil {
                if let data = data {
                    cell.postImageView.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
}

// MARK: - FeedViewModelOutput

extension FeedViewController: FeedViewModelOutput {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func showError(message: String) {
        DispatchQueue.main.async {
            AlertManager.showAlert(on: self, title: "Error", message: message)
        }
    }
}
