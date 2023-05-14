//
//  AlbumDetayViewModel.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 10.05.2023.
//

import Foundation

class AlbumViewModel : ObservableObject {
    @Published var myAlbumDetayYapiViewModel : AlbumDetayYapiViewModel?
    let downloaderClient = Downloader()
    func albumDetayMap(albumId : Int) {
        downloaderClient.AlbumDetayGetir(albumId: albumId) { (sonuc) in
            switch sonuc {
            case .failure(let hata):
                print(hata)
            case .success(let myAlbumDetay):
                    DispatchQueue.main.async {
                        self.myAlbumDetayYapiViewModel = AlbumDetayYapiViewModel(albumDetay: myAlbumDetay)
                    }
            }
        }
    }
}

struct AlbumDetayYapiViewModel {
    let albumDetay : AlbumDetayModeli
    
    var albumDate : String {
        albumDetay.releaseDate
    }
    
    var albumIsmi : String {
        albumDetay.title
    }
    
    var albumGoreseli: String {
        albumDetay.cover
    }
    
    var albumId : Int {
        albumDetay.id
    }

    var sarkiAdi : String {
        albumDetay.tracks.data [0].title
    }
    
    var sarkiSure : Int {
        albumDetay.duration
    }
}
