//
//  CoreDataManager.swift
//  Pics Gallery
//
//  Created by Леонид Кузнецов on 23.10.2020.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    
    func saveImage(id: Int, image: UIImage) {
        
        guard let appDelegate   = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext      = appDelegate.persistentContainer.viewContext
        
        let entity  = NSEntityDescription.entity(forEntityName: "PictureEntity", in: managedContext)!
        let picture = NSManagedObject(entity: entity, insertInto: managedContext)
        
        picture.setValue(id, forKeyPath: "id")
        picture.setValue(image.pngData(), forKeyPath: "pictureData")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
    
    func fetchImage(id: Int) -> UIImage? {
        
        guard let appDelegate   = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext      = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<PictureEntity>(entityName: "PictureEntity")
        
        do {
            let pictureEntity = try managedContext.fetch(fetchRequest)
            var image: UIImage?
            for picture in pictureEntity {
                if picture.id == id {
                    image = UIImage(data: picture.pictureData!)
                    break
                }
            }
            return image
        } catch let error as NSError {
            print("Could not fetch. \(error)")
            return nil
        }
    }
    
    
    func checkById(id: Int) -> Bool? {
        
        guard let appDelegate   = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext      = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<PictureEntity>(entityName: "PictureEntity")
        
        do {
            let pictureEntity = try managedContext.fetch(fetchRequest)
            var idExists = false
            for picture in pictureEntity {
                if picture.id == id {
                    idExists = true
                    break
                }
            }
            return idExists
        } catch let error as NSError {
            print("Could not fetch. \(error)")
            return nil
        }
    }
}
