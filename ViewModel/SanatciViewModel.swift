//
//  SanatciViewModel.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 9.05.2023.
//

import Foundation
import SwiftUI

class SanatciViewModel : ObservableObject {
    @Published var mySanatciDetayYapiViewModel = [SanatciDetayYapiViewModel]()
    let downloaderClient = Downloader()
    func sanatciDetayMap(sanatciId : Int) {
        downloaderClient.SanatciDetayGetir(sanatciId: sanatciId) { (sonuc) in
            switch sonuc {
            case .failure(let hata):
                print(hata)
            case .success(let mySanatciDetay):
                if let sanatciDetay = mySanatciDetay{
                    DispatchQueue.main.async {
                        self.mySanatciDetayYapiViewModel = sanatciDetay.map(SanatciDetayYapiViewModel.init)
                    }
                }
            }
        }
    }
}

    struct SanatciDetayYapiViewModel {
        let sanatciDetay : SanatciDetayModeli
        
        var id : Int {
            sanatciDetay.id
        }
        
        var albumGorsel : String {
            sanatciDetay.album.cover
        }
        
        var albumIsmi : String {
            sanatciDetay.album.title
        }
        
        var albumId : Int {
            sanatciDetay.album.id
        }
    }

