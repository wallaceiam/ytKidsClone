//
//  ContentView.swift
//  ytKidsClone
//
//  Created by Chris on 20/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .background(.black)
                
            VideoList()
        }.background(.black)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(.black)
    }
}
