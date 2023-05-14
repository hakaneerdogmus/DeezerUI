//
//  FavoriView.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 13.05.2023.
//
import SwiftUI
import AVFoundation



var myLocalStorageManagerFav = LocalStorageManager()
struct FavoriView: View {
    @ObservedObject var myLocalStorageViewModel = LocalStorageViewModel()
    var sarkiId: Int
    @StateObject private var soundManager = SoundManager()
    @State var playBool = false
    @State var control: Bool = false
    private func formatSure(sure: Int) -> String{
        var stringSure: String = ""
        if( sure / 60 < 10)
        {
            stringSure = "0\(sure/60):"
        }
        else
        {
            stringSure = "\(sure/60):"
        }
        if(sure % 60 < 10)
        {
            stringSure += "0\(sure%60)\""
        }
        else
        {
            stringSure += "\(sure%60)\""
        }
        return stringSure
    }
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: myLocalStorageViewModel.myLocalStorageYapiViewModel?.cover ?? "")) { phase in
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
            HStack{
                VStack(alignment: .leading, spacing: 6){
                    Text(myLocalStorageViewModel.myLocalStorageYapiViewModel?.title ?? "Sarki Adı")
                        .font(.title)
                        .offset(x: 20)
                    Text(formatSure(sure: myLocalStorageViewModel.myLocalStorageYapiViewModel?.duration ?? 0))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Button(action: {
                    control = myLocalStorageManager.storagedData.contains(myLocalStorageViewModel.myLocalStorageYapiViewModel?.sarkiId ?? 0) ? true : false
                    control.toggle()
                    if(control == true)
                    {
                        myLocalStorageManager.saveData(kaydetInt: myLocalStorageViewModel.myLocalStorageYapiViewModel?.sarkiId ?? 0)
                        myLocalStorageManager.loadData()
                    }
                    else
                    {
                        myLocalStorageManager.deleteData(silinecekData: myLocalStorageViewModel.myLocalStorageYapiViewModel?.sarkiId ?? 0)
                        myLocalStorageManager.loadData()
                    }
                    print(sarkiId)
                }, label: {
                    if(control == true || myLocalStorageManager.storagedData.contains(myLocalStorageViewModel.myLocalStorageYapiViewModel?.sarkiId ?? 0))
                    {
                        Image(systemName: "heart.fill")
                            .frame(width: 5, height: 5)
                            .font(.largeTitle)
                            .padding()
                    }else
                    {
                        Image(systemName: "heart")
                            .frame(width: 5, height: 5)
                            .font(.title)
                            .padding()
                    }
                })
                .contentShape(Rectangle())
                .offset(y:-20)
                .padding()
            }
        }
        .frame(height: 100)
        .background(RoundedRectangle(cornerRadius: 0).stroke().border(.black, width: 2).cornerRadius(0))
        .padding()
        .onTapGesture {
            soundManager.playSound(sound: myLocalStorageViewModel.myLocalStorageYapiViewModel?.preview ?? "")
            playBool.toggle()
            if playBool{
                soundManager.audioPlayer?.play()
            }else
            {
                soundManager.audioPlayer?.pause()
            }
        }
        .onAppear(perform: {
            self.myLocalStorageViewModel.localStorageMap(sarkiId: sarkiId)
        })
    }
}
struct FavoriView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriView(sarkiId: 2011995227)
    }
}
