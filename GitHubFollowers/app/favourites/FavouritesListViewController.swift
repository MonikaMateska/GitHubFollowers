import UIKit

class FavouritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        do {
            let favourites = try PersistenceManager.retreiveFavourites()
            print(favourites)
        } catch {
            
        }
    }

}
