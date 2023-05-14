//
//  AlbumSarkiView.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 13.05.2023.
//

import SwiftUI

struct AlbumSarkiView: View {
    var albumId: Int
    var sarkiGorsel: String
    @ObservedObject var myAlbumSarkiViewModel = AlbumSarkiViewModel()
    init(albumId: Int, sarkiGorsel: String, albumSarkiViewModel: AlbumSarkiViewModel = AlbumSarkiViewModel()) {
        self.albumId = albumId
        self.sarkiGorsel = sarkiGorsel
        self.myAlbumSarkiViewModel.albumSarkiMap(albumId: albumId)
    }
    private let adaptiveCoulumns = [
        GridItem(.adaptive(minimum: DeviceData.width / 2))
    ]
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: adaptiveCoulumns, spacing: 10) {
                    ForEach(myAlbumSarkiViewModel.myAlbumSarkiYapiViewModel, id: \.sarkiId) { albumSarki in
                        SarkiGorselView(sarkiGorseli: sarkiGorsel, sarkiId: albumSarki.sarkiId, sarkiAdı: albumSarki.sarkiIsmi, sarkiSure: albumSarki.sure, previewSound: albumSarki.onIzleme)
                    }
                }
            }
        }
    }
}
struct AlbumSarkiView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSarkiView(albumId: 0, sarkiGorsel: "")
    }
}
