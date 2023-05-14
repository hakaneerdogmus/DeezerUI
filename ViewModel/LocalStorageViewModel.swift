//
//  LocalStorageViewModel.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 13.05.2023.
//

import Foundation


class LocalStorageViewModel : ObservableObject {
    @Published var myLocalStorageYapiViewModel : LocalStorageYapiViewModel?
    let downloaderClient = Downloader()
    func localStorageMap(sarkiId : Int) {
        downloaderClient.LocalStorageGetir(sarkiId: sarkiId) { (sonuc) in
            switch sonuc {
            case .failure(let hata):
                print(hata)
            case .success(let myLocalStorage):
                    DispatchQueue.main.async {
                        self.myLocalStorageYapiViewModel = LocalStorageYapiViewModel(localStorage: myLocalStorage)
                    }
            }
        }
    }
}


struct LocalStorageYapiViewModel {
    let localStorage : LocalStorageModel
    
    var title : String {
        localStorage.title
    }
    
    var duration : Int {
        localStorage.duration
    }
    
    var preview : String {
        localStorage.preview
    }
    
    var cover : String {
        localStorage.album.cover
    }
    
    var sarkiId : Int {
        localStorage.id
    }
}
