//
//  SarkiGorselView.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 13.05.2023.
//

import SwiftUI
import AVFoundation

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?
    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
}
var myLocalStorageManager = LocalStorageManager()
struct SarkiGorselView: View {
    var sarkiGorseli : String
    var sarkiId: Int
    var sarkiAdı : String
    var sarkiSure: Int
    var previewSound: String
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
            AsyncImage(url: URL(string: sarkiGorseli)) { phase in
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
                    
                    Text(sarkiAdı)
                        .font(.title)
                        .offset(x: 20)
                    
                    Text(formatSure(sure: sarkiSure))
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Button(action: {
                    control = myLocalStorageManager.storagedData.contains(sarkiId) ? true : false
                 
                    control.toggle()
                    if(control == true)
                    {
                        myLocalStorageManager.saveData(kaydetInt: sarkiId)
                    }
                    else
                    {
                        myLocalStorageManager.deleteData(silinecekData: sarkiId)
                    }
                    print(sarkiId)
                }, label: {
                    
                    if(control == true || myLocalStorageManager.storagedData.contains(sarkiId))
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
            soundManager.playSound(sound: previewSound)
            playBool.toggle()

            if playBool{
                soundManager.audioPlayer?.play()
            }else
            {
                soundManager.audioPlayer?.pause()
            }
        }    }
}
struct SarkiGorselView_Previews: PreviewProvider {
    static var previews: some View {
        SarkiGorselView(sarkiGorseli: "https://api.deezer.com/artist/5618818/image", sarkiId: 0, sarkiAdı: "asfad", sarkiSure: 650, previewSound: "https://cdns-preview-5.dzcdn.net/stream/c-57f8887384a0f02615bfe1c32558e482-2.mp3")
    }
}
