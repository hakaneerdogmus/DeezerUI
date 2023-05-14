//
//  AlbumIdModeli.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 12.05.2023.
//

import Foundation

// MARK: - AlbumDetayModeli
struct AlbumSarkiDetayModeli: Codable {
    let data: [AlbumSarki]
    let total: Int
}

// MARK: - Datum
struct AlbumSarki: Codable {
    let id: Int
    let readable: Bool
    let title, titleShort, titleVersion, isrc: String
    let link: String
    let duration, trackPosition, diskNumber, rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics, explicitContentCover: Int
    let preview: String
    let md5Image: String
    let artist: Sarkici
    let type: String

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case isrc, link, duration
        case trackPosition = "track_position"
        case diskNumber = "disk_number"
        case rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case md5Image = "md5_image"
        case artist, type
    }
}

// MARK: - Artist
struct Sarkici: Codable {
    let id: Int
    let name: String
    let tracklist: String
    let type: String
}
