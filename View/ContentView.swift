//
//  ContentView.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 8.05.2023.
//

import SwiftUI



struct ContentView: View {
    @State private var resetButtonTapped = false
    @State private var selectedTab = 1
    @ObservedObject var myKatagoriListeViewModel : KatagoriListeViewModel
    @State var refreshBool : Bool = false
    @ObservedObject var myStorageManager = LocalStorageManager()
    init() {
        self.myKatagoriListeViewModel = KatagoriListeViewModel()
        self.myKatagoriListeViewModel.katagoriMap()
        myLocalStorageManager.Temizle()
    }
    private let adaptiveCoulumns = [
        GridItem(.adaptive(minimum: DeviceData.width / 2 - 20))
        ]
    private let adaptiveCoulumns1 = [
        GridItem(.adaptive(minimum: DeviceData.width  ))
        ]
    var body: some View {
        NavigationView{
            if myKatagoriListeViewModel.isLoading {
                ProgressView("Yükleniyor...")
            }else{
                TabView(selection: $selectedTab){
                    ScrollView{
                        LazyVGrid(columns: adaptiveCoulumns, spacing: 10){
                            ForEach(myKatagoriListeViewModel.myKatagoriViewModeli, id: \.id) { katagori in
                                HStack{
                                    NavigationLink(destination: {
                                        KatagoriDetayView(gelenId: katagori.id)
                                        //KatagoriDetay sayfasına geçtiğinde gözükecek isim
                                            .navigationBarTitleDisplayMode(.inline)
                                            .toolbar{
                                                ToolbarItem(placement: .principal) {
                                                    Text(katagori.name)
                                                        .font(.largeTitle.bold())
                                                        .accessibilityAddTraits(.isHeader)
                                                }
                                            }
                                    }, label: {
                                        KatagoriView(name: katagori.name, picturreUrl: katagori.picture)
                                    })
                                }
                            }
                        }
                    }//Ana sayfa başlığı
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .principal) {
                            Text("Katagoriler")
                                .font(.largeTitle.bold())
                                .accessibilityAddTraits(.isHeader)
                        }
                    }
                    .tabItem({
                        Image(systemName: "music.note.list")
                    })
                    .tag(1)
                    
                    
                        FavView(sarkiDizisi: myStorageManager.storagedData, tikla: resetButtonTapped)
                        .tabItem({
                            Image(systemName: "heart")
                        })
                        .tag(2)
                }.padding()
                    .edgesIgnoringSafeArea(.top)
                    .onChange(of: selectedTab) { _ in
                        myStorageManager.loadData()
                        resetButtonTapped.toggle()
                    }
            }
        }.onAppear{
            myKatagoriListeViewModel.katagoriMap()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
