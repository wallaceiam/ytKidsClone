//
//  VideoThumbnail.swift
//  ytKidsClone
//
//  Created by Chris on 20/06/2022.
//

import SwiftUI

struct VideoThumbnail: View {
    var video: Video
    
    var body: some View {
        let w = UIScreen.screenWidth / 4
        VStack {
            video.image
                .resizable()
                .frame(width: w, height: w * 0.5625)
            
            Text(video.title)
                .font(.subheadline)
                .fontWeight(.light)
                .frame(width: w, height: 40)
                .clipped()

        }
        .overlay {
            Rectangle().stroke(.white, lineWidth: 4)
        }
        .shadow(radius: 7)
        .padding()
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct VideoThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VideoThumbnail(video: videos[0])
        }
    }
}
