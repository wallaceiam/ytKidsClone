//
//  Video.swift
//  ytKidsClone
//
//  Created by Chris on 20/06/2022.
//

import Foundation
import SwiftUI

struct Video: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var description: String
    var uploader: String
    
    var image: Image {
        Image(id + "_thumb")
    }
    
    var videoUrl: URL {
        URL(fileURLWithPath: Bundle.main.path(forResource: id + "_video", ofType: "mp4")!)
    }
}
