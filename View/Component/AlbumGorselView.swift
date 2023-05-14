//
//  AlbumGorselView.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 10.05.2023.
//

import SwiftUI

struct AlbumGorselView: View {
    var albumId: Int
    @ObservedObject var myAlbumDetayViewModel = AlbumViewModel()
    init(albumId: Int, myAlbumDetayViewModel: AlbumViewModel = AlbumViewModel()) {
        self.albumId = albumId
        self.myAlbumDetayViewModel.albumDetayMap(albumId: albumId)
    }
    var body: some View {
            VStack{
                HStack{
                    Spacer()
                    AsyncImage(url: URL(string: myAlbumDetayViewModel.myAlbumDetayYapiViewModel?.albumGoreseli ?? "")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: DeviceData.width * 0.2, height: DeviceData.height * 0.2)
                        case .failure(let error):
                            Text("Error: \(error.localizedDescription)")
                        case .empty:
                            Text("")
                        @unknown default:
                            Text("Unknown")
                        }
                    }
                    Divider().background(RoundedRectangle(cornerRadius: 1)).border(.black,width: 2)
                    Spacer()
                    Spacer()
                    VStack{
                        Text(myAlbumDetayViewModel.myAlbumDetayYapiViewModel?.albumIsmi ?? "")
                            .font(.title)
                        Text(myAlbumDetayViewModel.myAlbumDetayYapiViewModel?.albumDate ?? "")
                            .font(.subheadline)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .frame(height: 100)
                .background(RoundedRectangle(cornerRadius: 25).stroke().border(.black, width: 2).cornerRadius(20))
                .padding()
                Spacer()
        }
    }
}

struct AlbumGorselView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumGorselView(albumId: 0)
    }
}
