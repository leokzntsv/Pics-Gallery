//
//  Picture.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 21.10.2020.
//

import Foundation

struct Picture: Codable {
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    var isDownloaded = false
}
