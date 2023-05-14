//
//  SanatciDetayView.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 10.05.2023.
//

import SwiftUI

struct SanatciDetayView: View {
    var sanatciId: Int
    var sanatciPicturre: String
    @ObservedObject var myAlbumDetayViewModel = AlbumViewModel()
    @ObservedObject var mySanatciDetayViewModel = SanatciViewModel()
    init(sanatciId: Int, sanatciPicturre: String, sanatciDetayViewModel: SanatciViewModel = SanatciViewModel()) {
        self.sanatciId = sanatciId
        self.sanatciPicturre = sanatciPicturre
        self.mySanatciDetayViewModel.sanatciDetayMap(sanatciId: sanatciId)
    }
    private let adaptiveCoulumns = [
        GridItem(.adaptive(minimum: DeviceData.width / 2))
        ]
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: adaptiveCoulumns, spacing: 10){
                    AsyncImage(url: URL(string: sanatciPicturre)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: DeviceData.width * 0.8, height: DeviceData.height * 0.2)
                        case .failure(let error):
                            Text("Error: \(error.localizedDescription)")
                        case .empty:
                            Text("No Image")
                        @unknown default:
                            Text("Unknown")
                        }
                    }
                    ForEach(mySanatciDetayViewModel.mySanatciDetayYapiViewModel, id: \.id){ sanatciDetayi in
                            NavigationLink(destination: {
                                AlbumSarkiView(albumId: sanatciDetayi.albumId, sarkiGorsel: sanatciDetayi.albumGorsel)
                            }, label: {
                                AlbumGorselView(albumId: sanatciDetayi.albumId)
                            })
                    }
                }
            }
        }
    }
}

struct SanatciDetayView_Previews: PreviewProvider {
    static var previews: some View {
        SanatciDetayView(sanatciId: 0, sanatciPicturre: "")
    }
}
