import UIKit

class FavouritesListViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero)
    
    var favourites = [Follower]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureViewController()
        configureTableView()
        retreiveFavourites()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseID)
    }
    
    private func retreiveFavourites() {
        showLoadingView()
        do {
            let favourites = try PersistenceManager.retreiveFavourites()
            hideLoadingView()
            self.favourites = favourites
            if self.favourites.isEmpty {
                showEmptyStateView(with: "No favourites?\nAdd one on the follower screen.", in: self.view)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } catch {
            hideLoadingView()
            if let error = error as? PersistenceError {
                presentAlert(message: error.rawValue)
            }
        }
    }
}

extension FavouritesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseID) as! FavouriteCell
        let index = indexPath.row
        let follower = favourites[index]
        
        cell.set(favourite: follower)
        return cell
    }
    
}
