//
//  PhotosTableViewController.swift
//  GORA Test API
//
//  Created by username on 19.01.2022.
//

import UIKit

class PhotosTableViewController: UITableViewController {
    var photos: [Photo] = []
    
    var dataSource: UITableViewDiffableDataSource<Section, Item>! = nil
    
    private var imageObjects = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.imageProperties.cornerRadius = 8
            content.image = item.image
            content.text = item.text
            ImageCache.publicCache.load(url: item.url as NSURL, item: item) { (fetchedItem, image) in
                if let img = image, img != fetchedItem.image {
                    var updatedSnapshot = self.dataSource.snapshot()
                    if let datasourceIndex = updatedSnapshot.indexOfItem(fetchedItem) {
                        let item = self.imageObjects[datasourceIndex]
                        item.image = img
                        updatedSnapshot.reloadItems([item])
                        self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
                    }
                }
            }
            cell.contentConfiguration = content
            return cell
        }
        
        self.dataSource.defaultRowAnimation = .fade
        
        if imageObjects.isEmpty {
            for index in 0..<photos.count {
                if let url = URL(string: photos[index].thumbnailUrl) {
                        self.imageObjects.append(Item(image: ImageCache.publicCache.placeholderImage,
                                                      url: url,
                                                      text: photos[index].title))
                    }
                }
                var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                initialSnapshot.appendSections([.main])
                initialSnapshot.appendItems(self.imageObjects)
                self.dataSource.apply(initialSnapshot, animatingDifferences: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            let photo = photos[indexPath.row]
            detailViewController.photo = photo
        }
    }
}
