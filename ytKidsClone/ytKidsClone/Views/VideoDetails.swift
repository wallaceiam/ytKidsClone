//
//  VideoDetails.swift
//  ytKidsClone
//
//  Created by Chris on 20/06/2022.
//

import SwiftUI
import ARKit
import AVKit

struct VideoDetails: View {
    var video: Video
    @State var player: AVPlayer = AVPlayer()
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear {
                    player = AVPlayer(url: video.videoUrl)
                    player.play()
                }
                .onDisappear {
                    player.pause()
                }
                .onTapGesture {
                    player.pause()
                }
                .frame(alignment: .topLeading)
            
            SmallVideoList()
            
        }
    }
}

struct VideoDetails_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetails(video: videos[0])
    }
}
