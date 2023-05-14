//
//  KatagoriDetayView.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 9.05.2023.
//

import SwiftUI

struct KatagoriDetayView: View {
      var gelenId: Int
    @ObservedObject var myKatagoriDetayViewModel = KatagoriDetayViewModel()
    init(gelenId: Int, katagoriDetayViewModel: KatagoriDetayViewModel = KatagoriDetayViewModel()) {
        self.gelenId = gelenId
        self.myKatagoriDetayViewModel.katagoriDetayMap(id: gelenId)
    }
    private let adaptiveCoulumns = [
        GridItem(.adaptive(minimum: DeviceData.width / 2 - 20))
        ]
    var body: some View {
        NavigationView{
            if myKatagoriDetayViewModel.isLoading {
                ProgressView("Yükleniyor.....")
            }else
            {
                ScrollView{
                    LazyVGrid(columns: adaptiveCoulumns, spacing: 10){
                        ForEach(myKatagoriDetayViewModel.myKatagoriDetayYapiViewModel, id: \.id){ katagoriDetayi in
                            HStack{
                                NavigationLink(destination: {
                                    SanatciDetayView(sanatciId: katagoriDetayi.id, sanatciPicturre: katagoriDetayi.picture)
                                    //SanatçıiDetay sayfasına geçtiğinde gözükecek isim
                                        .navigationBarTitleDisplayMode(.inline)
                                        .toolbar{
                                            ToolbarItem(placement: .principal) {
                                                Text(katagoriDetayi.name)
                                                    .font(.largeTitle.bold())
                                                    .accessibilityAddTraits(.isHeader)
                                            }
                                        }
                                }, label: {
                                    SanatciListView(name: katagoriDetayi.name, picturreUrl: katagoriDetayi.picture)
                                })
                            }
                        }
                    }
                }
            }
        }.onAppear{
            myKatagoriDetayViewModel.katagoriDetayMap(id: gelenId)
        }
    }
}

struct KatagoriDetayView_Previews: PreviewProvider {
    static var previews: some View {
        KatagoriDetayView(gelenId: 0)
    }
}
