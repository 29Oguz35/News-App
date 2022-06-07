//
//  NewsTableViewCellViewModel.swift
//  NewsApp
//
//  Created by naruto kurama on 28.04.2022.
//

import Foundation

class NewsTableViewCellViewModel {
    let title : String
    let subTitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title : String , subTitle: String, imageURL: URL?) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}
