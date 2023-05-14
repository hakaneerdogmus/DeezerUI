//
//  Katagori.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 8.05.2023.
//

import Foundation


struct KatagoriModeli : Codable {
    let id : Int
    let name : String
    let picture : String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let type: String
       enum CodingKeys: String, CodingKey {
           case id, name, picture
           case pictureSmall = "picture_small"
           case pictureMedium = "picture_medium"
           case pictureBig = "picture_big"
           case pictureXl = "picture_xl"
           case type
       }
   }

struct GelenKatagoriler: Codable {
    let data: [KatagoriModeli]
    enum CodingKeys : String, CodingKey{
        case data = "data"
    }
}

  
