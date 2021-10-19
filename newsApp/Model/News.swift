//
//  News.swift
//  newsApp
//
//  Created by Thaddeus Lorenz on 10/19/21.
//

import Foundation

class News {
    let title: String
    let imageURL: URL?
    var imageData: Data? = nil
    init(
        title: String,
        imageURL: URL?
    )
    {
        self.title = title
        self.imageURL = imageURL
    }
}
