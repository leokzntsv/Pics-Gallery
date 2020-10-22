//
//  Picture.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 21.10.2020.
//

import Foundation

struct Picture: Codable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
