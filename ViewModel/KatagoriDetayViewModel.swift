//
//  KatagoriDetayViewModel.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 9.05.2023.
//

import Foundation
import SwiftUI

class KatagoriDetayViewModel : ObservableObject {
   @Published var isLoading : Bool = false
    @Published var myKatagoriDetayYapiViewModel = [KatagoriDetayYapiViewModel]()
    let downloaderClient = Downloader()
    func katagoriDetayMap(id : Int) {
        isLoading = true
        downloaderClient.KatagoriDetayGetir(id: id) { (sonuc) in
            switch sonuc {
            case .failure(let hata):
                print(hata)
            case .success(let myKatagoriDetay):
                if let katagoriDetay = myKatagoriDetay{
                    DispatchQueue.main.async {
                        self.myKatagoriDetayYapiViewModel = katagoriDetay.map(KatagoriDetayYapiViewModel.init)
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    struct KatagoriDetayYapiViewModel {
        let detay : KatagoriDetayModeli
        
        var id : Int {
            detay.id
        }
        
        var name : String {
            detay.name
        }
        
        var picture : String {
            detay.picture
        }
        
        var pictureSmall : String {
            detay.pictureSmall
        }
        
        var pictureMedium : String {
            detay.pictureMedium
        }
        
        var pictureBig : String {
            detay.pictureBig
        }
        
        var pictureXl : String {
            detay.pictureXl
        }
        
        var radio : Bool {
            detay.radio
        }
        
        var trackList : String {
            detay.tracklist
        }
        
        var type : String {
            detay.type
        }
    }
}
