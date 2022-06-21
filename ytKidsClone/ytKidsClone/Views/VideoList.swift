//
//  VideoList.swift
//  ytKidsClone
//
//  Created by Chris on 20/06/2022.
//

import SwiftUI

struct VideoList: View {
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(videos.shuffled()[..<20]) { video in
                        NavigationLink {
                            VideoDetails(video: video)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            VideoThumbnail(video: video)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList()
    }
}
