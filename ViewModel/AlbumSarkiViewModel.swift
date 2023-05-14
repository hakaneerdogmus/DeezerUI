//
//  AlbumIdViewModel.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 12.05.2023.
//

import Foundation
import SwiftUI

class AlbumSarkiViewModel : ObservableObject {
    @Published var myAlbumSarkiYapiViewModel = [AlbumSarkiYapiViewModel]()
    let downloaderClient = Downloader()
    func albumSarkiMap(albumId: Int){
        downloaderClient.AlbumSarkiGetir(albumId: albumId) { (sonuc) in
            switch sonuc{
            case.failure(let hata):
                print(hata)
            case.success(let albumSarkiDizisi):
                if let albumSarkiDetay = albumSarkiDizisi{
                    DispatchQueue.main.async {
                        self.myAlbumSarkiYapiViewModel = albumSarkiDetay.map(AlbumSarkiYapiViewModel.init)
                    }
                }
            }
        }
    }
}
    
    struct AlbumSarkiYapiViewModel {
        let albumSarki : AlbumSarki
        
        var sure : Int {
            albumSarki.duration
        }
        
        var sarkiIsmi : String {
            albumSarki.title
        }
        
        var onIzleme : String {
            albumSarki.preview
        }
        
        var sarkiId : Int {
            albumSarki.id
        }
        
        
  
    }

