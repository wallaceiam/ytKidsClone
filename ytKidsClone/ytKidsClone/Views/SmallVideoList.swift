//
//  VideoList.swift
//  ytKidsClone
//
//  Created by Chris on 20/06/2022.
//

import SwiftUI

struct SmallVideoList: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(videos.shuffled()[..<20]) { video in
                    NavigationLink {
                        VideoDetails(video: video)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        SmallVideoThumbnail(video: video)
                    }
                }
            }
        }
        
    }
}

struct SmallVideoList_Previews: PreviewProvider {
    static var previews: some View {
        SmallVideoList()
    }
}
