//
//  FavView.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 13.05.2023.
//

import SwiftUI

struct FavView: View {
     var sarkiIdDizisi = [Int]()
    var selectedTab: Bool
    @ObservedObject var myLocalStorageViewModel = LocalStorageViewModel()
    init(sarkiDizisi: [Int], tikla: Bool, localStorageViewModel: LocalStorageViewModel = LocalStorageViewModel()) {
        myLocalStorageManager.loadData()
        self.sarkiIdDizisi = sarkiDizisi
        print(sarkiDizisi)
        self.selectedTab = tikla
        print(selectedTab)
    }
    private let adaptiveCoulumns = [
        GridItem(.adaptive(minimum: DeviceData.width / 2))
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: adaptiveCoulumns, spacing: 6){
                if selectedTab {
                    ForEach(sarkiIdDizisi, id: \.self){data in
                        FavoriView(sarkiId: data)
                    }
                }
             }.refreshable {}
        }
    }
}

struct FavView_Previews: PreviewProvider {
    static var previews: some View {
        FavView(sarkiDizisi: [], tikla: true)
    }
}
