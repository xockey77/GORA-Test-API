//
//  UsersTableViewController.swift
//  GORA Test API
//
//  Created by username on 18.01.2022.
//

import UIKit

class UsersTableViewController: UITableViewController {

    var users: [User] = []
    var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        fetchAlbums()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = users[indexPath.row].name
        content.secondaryText = users[indexPath.row].username
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowAlbums", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAlbums" {
            let albumsViewController = segue.destination as! AlbumsTableViewController
            let indexPath = sender as! IndexPath
            let name = users[indexPath.row].name
            albumsViewController.title = "\(name)'s Albums"
            albumsViewController.albums = albums.filter{$0.userId == users[indexPath.row].id}
        }
    }
}

extension UsersTableViewController {
    
    func fetchUsers() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                return
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data {
                    self.users = Parser.parseArray(data: data, type: User())
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
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
    
    func fetchAlbums() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                return
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data {
                    self.albums = Parser.parseArray(data: data, type: Album())
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
