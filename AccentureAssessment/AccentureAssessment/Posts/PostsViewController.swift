//
//  PostsViewController.swift
//  AccentureAssessment
//
//  Created by Gurleen kaur on 12/5/25.
//

import UIKit

import UIKit

class PostsViewController: UIViewController {
    
    //MARK: Variable
    private let viewModel = PostsViewModel()
    var onFavoriteTapped: (() -> Void)?
    
    //MARK: Outlets
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var noPostsLabel: UILabel!
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 150
        viewModel.onPostsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.postsTableView.reloadData()
                self?.updateUI()
            }
        }
        viewModel.onError = { errorMessage in
            print("Error fetching posts: \(errorMessage)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchLaunchPosts()
//       viewModel.fetchRealmPosts()
        postsTableView.reloadData()
        updateUI()
    }
    
    //MARK: Functions
    func updateUI() {
        if viewModel.numberOfPosts() > 0 {
            noPostsLabel.isHidden = true
        } else {
            noPostsLabel.isHidden = false
        }
    }
    
    func navigateToLoginScreen() {
        UserDefaults.standard.removeObject(forKey: Constants.Strings.kIsLoggedIn)
        let storyboard = UIStoryboard(name: Constants.Storyboard.kMainStoryboard, bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: Constants.Identifier.kLoginViewController)
        
        if #available(iOS 13.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = scene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = loginVC
                sceneDelegate.window?.makeKeyAndVisible()
                return
            }
        }
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = loginVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    //MARK: Actions
    @IBAction func logoutButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: Constants.Alerts.kLogout, message: Constants.Alerts.kLogoutMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Alerts.kCancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.Alerts.kLogout, style: .destructive) { _ in
            self.navigateToLoginScreen()
        })
        present(alert, animated: true)
    }
}

//MARK: TableViewDelegate , TableViewDataSource
extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.kPostCell, for: indexPath) as! PostsTableViewCell
        let cellData = viewModel.post(at: indexPath.row)
        cell.setData(post: cellData)
        if let isCellFav =  cellData.isFavourite {
            cell.selectionStyle = isCellFav ? .none : .default
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellData = viewModel.post(at: indexPath.row)
        if let isFav = cellData.isFavourite, isFav == true {
         return
        }
        self.toggleFavorite(post: cellData, at: indexPath)
    }

    
    private func toggleFavorite(post: Post, at indexPath: IndexPath) {
        let alert = UIAlertController(title: Constants.Alerts.kAddPostToFavTitle, message: Constants.Alerts.kAddPostToFavMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.Alerts.kOK, style: .default) {
            (action) -> Void in
            let manager = DBManager()
            manager.updatePostForFavourite(id: post.id, isFav: true)
            self.viewModel.updatePost(at: indexPath.row, isFav: true)
            self.postsTableView.reloadData()
            if let cell = self.postsTableView.cellForRow(at: indexPath) as? PostsTableViewCell {
                cell.setData(post: self.viewModel.post(at: indexPath.row))
            }
        }
        let cancelAction = UIAlertAction(title: Constants.Alerts.kCancel, style: .cancel) {
            (action) -> Void in
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: false, completion: nil)
    }
}

