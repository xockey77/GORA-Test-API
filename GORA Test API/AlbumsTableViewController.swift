//
//  PhotosTableViewController.swift
//  GORA Test API
//
//  Created by username on 19.01.2022.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albums: [Album] = []
    var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = albums[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowPhotos", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhotos" {
            let photosViewController = segue.destination as! PhotosTableViewController
            let indexPath = sender as! IndexPath
            let title = albums[indexPath.row].title
            photosViewController.title = title
            photosViewController.photos = photos.filter{$0.albumId == albums[indexPath.row].id}
        }
    }
    
    func fetchPhotos() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                return
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data {
                    self.photos = Parser.parseArray(data: data, type: Photo())
                    return
                }
            } else {
                DispatchQueue.main.async {
                    self.showNetworkError()
                }
            }
        }
        dataTask.resume()
    }
}
