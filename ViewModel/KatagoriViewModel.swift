//
//  KatagoriViewModel.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 9.05.2023.
//

import Foundation

class KatagoriListeViewModel : ObservableObject {
    @Published var isLoading: Bool = false
    @Published var myKatagoriViewModeli = [KatagoriViewModel]()
    let downloaderClient = Downloader()
    func katagoriMap(){
        isLoading = true
        downloaderClient.KatagoriGetir() { (sonuc) in
            switch sonuc{
            case.failure(let hata):
                print(hata)
            case.success(let katagoriDizisi):
                if let katagoriDizisi = katagoriDizisi{
                    DispatchQueue.main.async {
                        self.myKatagoriViewModeli = katagoriDizisi.map(KatagoriViewModel.init)
                        self.isLoading = false
                    }
                }
            }
        }
    }
}

struct KatagoriViewModel {
    let katagori : KatagoriModeli
    
    var id : Int {
        katagori.id
    }
    
    var name : String {
        katagori.name
    }
    
    var picture : String {
        katagori.picture
    }
    
    var pictureSmall : String {
        katagori.pictureSmall
    }
    
    var pictureMedium : String {
        katagori.pictureMedium
    }
    
    var pictureBig : String {
        katagori.pictureBig
    }
    
    var pictureXl : String {
        katagori.pictureXl
    }
}
