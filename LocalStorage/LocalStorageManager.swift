//
//  DataManager.swift
//  DeezerUI
//
//  Created by Hakan ERDOĞMUŞ on 13.05.2023.
//

import Foundation
import SwiftUI




class LocalStorageManager : ObservableObject{
    var isLoading: Bool = false
     @Published var storagedData = [Int]()
        init() {
            loadData()
        }
     func saveData(kaydetInt: Int) {
         if(storagedData.contains(kaydetInt))
         {
             print("Already Saved")
         }
         else
         {
             storagedData.append(kaydetInt)
                    UserDefaults.standard.set(storagedData, forKey: "myKey")
                    print("\(kaydetInt) saved")
         }
        }
    func ContainBool(controlData:Int) -> Bool{
        return storagedData.contains(controlData)
    }
    func deleteData(silinecekData: Int){
        print(storagedData)
        if(self.storagedData.contains(silinecekData))
        {
            for i in 0...storagedData.count
            {
                print(storagedData[i])
                if(silinecekData == storagedData[i])
                   {
                    storagedData.remove(at: i)
                    print(storagedData)
                    UserDefaults.standard.set(storagedData, forKey: "myKey")
                    UserDefaults.standard.synchronize()
                    loadData()
                    return
                }
            }
            print("Data Silindi")
        }else
         {print("Bu data bulunamadı")
         }
    }
    func Temizle()
    {
        UserDefaults.standard.removeObject(forKey: "myKey")
        UserDefaults.standard.synchronize()
        print("Temizlendi")
        print(storagedData)
    }
     func loadData() {
         let numberArray:[Int] = (UserDefaults.standard.array(forKey: "myKey") as? [Int] ?? [] )
         if (numberArray.isEmpty)
         {
             print("Data Yok")
         }
         else
         {
             storagedData = numberArray

         }
    }
    
}

