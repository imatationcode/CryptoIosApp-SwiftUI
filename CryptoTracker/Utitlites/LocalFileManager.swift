//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 03/07/25.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // Create folder
        createFolderIfNotExists(folderName: folderName)
        
        // get path for image
        guard
            let imgData = image.pngData(),
            let url = getURLforImage(imageName: imageName, folderName: folderName)
            else {
//                print("Could not retrive image data passed , to be stored in file system")
                return
            }
        do {
            try imgData.write(to: url)
        } catch let error {
            let errorMessage = error.localizedDescription
//            print("Error while saving image to file system : \(errorMessage)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLforImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNotExists(folderName: String) {
        guard let url = getURLforFolder(folderName: folderName) else {
            return
        }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print("Error while creating folder : \(error.localizedDescription) , FolderName : \(folderName)")
            }
        }
    }
    
    private func getURLforFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
            else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    func getURLforImage(imageName: String, folderName: String ) -> URL? {
        guard let folderURL = getURLforFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
