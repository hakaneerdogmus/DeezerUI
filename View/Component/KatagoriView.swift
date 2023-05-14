//
//  CardView.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 9.05.2023.
//

import SwiftUI


struct KatagoriView: View {
    var name : String
    var picturreUrl: String
    var body: some View {
        ZStack{
            AsyncImage(url: URL(string: picturreUrl)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: DeviceData.width / 2 - 20, height: DeviceData.height * 0.2)
                case .failure(let error):
                    Text("Error: \(error.localizedDescription)")
                case .empty:
                    Text("No Image")
                @unknown default:
                    Text("Unknown")
                }
            }
            Text(name)
                .font(.title2.bold())
                .bold()
                .offset(y: 50)
        }.cornerRadius(15)
            .foregroundColor(.white)
    }
}

struct KatagoriView_Previews: PreviewProvider {
    static var previews: some View {
        KatagoriView(name: "", picturreUrl: "")
    }
}
