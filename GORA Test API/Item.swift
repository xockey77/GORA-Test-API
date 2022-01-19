//
//  Item.swift
//  GORA Test API
//
//  Created by username on 19.01.2022.
//

import UIKit

enum Section {
    case main
}

class Item: Hashable {
    
    var image: UIImage!
    let url: URL!
    let identifier = UUID()
    var text: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(image: UIImage, url: URL, text: String) {
        self.image = image
        self.url = url
        self.text = text
    }

}
