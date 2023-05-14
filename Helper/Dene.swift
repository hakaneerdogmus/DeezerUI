//
//  Dene.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 10.05.2023.
//

import SwiftUI

struct Dene: View {
    
    var picturreUrl: String
    
    @ObservedObject var myAlbumDetayViewModel = AlbumViewModel()
    
    var body: some View {
        VStack{
            //            Button(action: {
            //                Downloader().SanatciDetayGetir(sanatciId: 5618818){ sonuc in
            //                    switch sonuc {
            //                    case .success(let gelenCvp):
            //                        print(gelenCvp)
            //                    case .failure(let hata):
            //                        print(hata)
            //                    }
            //                }
            //            }, label: {
            //                Text("Dene")
            //            })
            
          Text("sa")
            Text(myAlbumDetayViewModel.myAlbumDetayYapiViewModel?.albumDate ?? "Çıkış")
                
        }
    }
}

struct Dene_Previews: PreviewProvider {
    static var previews: some View {
        Dene(picturreUrl: "")
    }
}
