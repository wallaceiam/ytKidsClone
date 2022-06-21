//
//  VideoThumbnail.swift
//  ytKidsClone
//
//  Created by Chris on 20/06/2022.
//

import SwiftUI

struct SmallVideoThumbnail: View {
    var video: Video
    
    var body: some View {
        let w = UIScreen.screenWidth / 7
        ZStack {
            video.image
                .resizable()
                .frame(width: w, height: w * 0.5625)
            
            Text(video.title)
                .offset(y: -w * 0.5625)
                .padding(.bottom, -w * 0.5625)
                .font(.subheadline)
                .frame(width: w, height: 20)
                .clipped()

        }
        .overlay {
            Rectangle().stroke(.gray, lineWidth: 4)
        }
        .shadow(radius: 7)
        .padding()
    }
}

struct SmallVideoThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SmallVideoThumbnail(video: videos[0])
        }
    }
}
