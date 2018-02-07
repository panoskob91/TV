//
//  Show.swift
//  TV
//
//  Created by Paagiotis  Kompotis  on 07/02/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import UIKit

class Show {
    let imageURL: String?
    let title: String
    let averageRating: Float?
    let summary: String?
    
    init(title: String, averageRating: Float?, summary: String?, imageURL: String?) {
        self.title = title
        self.averageRating = averageRating
        self.summary = summary
        self.imageURL = imageURL
    }
}
