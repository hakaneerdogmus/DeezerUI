//
//  Downloader.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 8.05.2023.
//

import Foundation


class Downloader {
    
    func KatagoriGetir(completion: @escaping(Result<[KatagoriModeli]?, DownloaderError>) -> Void) {
        guard let url = URL(string:
                                "https://api.deezer.com/genre") else {
            return completion(.failure(.yanlisUrl))
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil
            else{
                return completion(.failure(.veriGelmedi))
            }
            guard let KatagoriCevabi = try? JSONDecoder().decode(GelenKatagoriler.self, from: data)
            else{
                return completion(.failure(.veriIslenemedi))
            }
            completion(.success(KatagoriCevabi.data))
            
        }.resume()
    }
    
    
    func KatagoriDetayGetir(id: Int, completion: @escaping(Result<[KatagoriDetayModeli]?, DownloaderError>) -> Void) {
        guard let url = URL(string:
                                "https://api.deezer.com/genre/\(id)/artists") else {
            return completion(.failure(.yanlisUrl))
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil
            else{
                return completion(.failure(.veriGelmedi))
            }
            guard let katagoriDetayCevabi = try? JSONDecoder().decode(GelenKatagoriDetay.self, from: data)
            else{
                return completion(.failure(.veriIslenemedi))
            }
            completion(.success(katagoriDetayCevabi.data))
        }.resume()
    }
    
    func SanatciDetayGetir(sanatciId: Int, completion: @escaping(Result<[SanatciDetayModeli]?, DownloaderError>) -> Void) {
        guard let url = URL(string:
                                "https://api.deezer.com/artist/\(sanatciId)/top?limit=50") else {
            return completion(.failure(.yanlisUrl))
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil
            else{
                return completion(.failure(.veriGelmedi))
            }
            guard let sanatciDetayCevabi = try?
                    JSONDecoder().decode(GelenSanatciDetay.self, from: data)
            else{
                return completion(.failure(.veriIslenemedi))
            }
            completion(.success(sanatciDetayCevabi.data))
        }.resume()
    }
    
    
    func AlbumDetayGetir(albumId: Int, completion: @escaping (Result<AlbumDetayModeli, DownloaderError>) -> Void) {
        guard let url = URL(string:
                                "https://api.deezer.com/album/\(albumId)") else {
            return completion(.failure(.yanlisUrl))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.veriGelmedi))
            }
            guard let gelenAlbumDetayi = try? JSONDecoder().decode(AlbumDetayModeli.self, from: data) else {
                return completion(.failure(.veriIslenemedi))
            }
            completion(.success(gelenAlbumDetayi))
        }.resume()
    }
    
    func AlbumSarkiGetir(albumId: Int, completion: @escaping (Result<[AlbumSarki]?, DownloaderError>) -> Void) {
        guard let url = URL(string:
                                "https://api.deezer.com/album/\(albumId)/tracks") else {
            return completion(.failure(.yanlisUrl))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.veriGelmedi))
            }
            guard let gelenSarkiModeli = try? JSONDecoder().decode(AlbumSarkiDetayModeli.self, from: data) else {
                return completion(.failure(.veriIslenemedi))
            }
            completion(.success(gelenSarkiModeli.data))
        }.resume()
    }
    
    func LocalStorageGetir(sarkiId: Int, completion: @escaping (Result<LocalStorageModel, DownloaderError>) -> Void) {
        guard let url = URL(string:
                                "https://api.deezer.com/track/\(sarkiId)") else {
            return completion(.failure(.yanlisUrl))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.veriGelmedi))
            }
            guard let gelenLocalStorage = try? JSONDecoder().decode(LocalStorageModel.self, from: data) else {
                return completion(.failure(.veriIslenemedi))
            }
            completion(.success(gelenLocalStorage))
        }.resume()
    }
}

enum DownloaderError : Error {
    case yanlisUrl
    case veriGelmedi
    case veriIslenemedi
}
