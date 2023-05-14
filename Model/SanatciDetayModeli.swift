//
//  SanatciDetayModeli.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 10.05.2023.
//


import Foundation

// MARK: - SanatciDetayModeli
struct GelenSanatciDetay: Codable {
    let data: [SanatciDetayModeli]
    let total: Int
}

// MARK: - SanatciDetayModeli
struct SanatciDetayModeli: Codable {
    let id: Int
    let readable: Bool
    let title, titleShort: String
    let titleVersion: String
    let link: String
    let duration, rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics, explicitContentCover: Int
    let preview: String
    let contributors: [Contributor]
    let md5Image: String
    let artist: Artist
    let album: Album
    let type: DatumType

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case link, duration, rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview, contributors
        case md5Image = "md5_image"
        case artist, album, type
    }
}

// MARK: - Album
struct Album: Codable {
    let id: Int
    let title: String
    let cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let md5Image: String
    let tracklist: String
    let type: AlbumType

    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case tracklist, type
    }
}

enum AlbumType: String, Codable {
    case album = "album"
}

// MARK: - Artist
struct Artist: Codable {
    let id: Int
    let name: String
    let tracklist: String
    let type: ArtistType
}



enum ArtistType: String, Codable {
    case artist = "artist"
}

// MARK: - Contributor
struct Contributor: Codable {
    let id: Int
    let name: String
    let link, share, picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let radio: Bool
    let tracklist: String
    let type: ArtistType
    let role: Role

    enum CodingKeys: String, CodingKey {
        case id, name, link, share, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type, role
    }
}

enum Role: String, Codable {
    case featured = "Featured"
    case main = "Main"
}



enum DatumType: String, Codable {
    case track = "track"
}
