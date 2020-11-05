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
        let idString = "\(id)"
        let predicate = NSPredicate(format: "id == %@", idString)
        fetchRequest.predicate = predicate
        
        do {
            let pictureEntity = try managedContext.fetch(fetchRequest)
            guard let pictureData = pictureEntity.first?.pictureData else { return nil }
            return UIImage(data: pictureData)
        } catch let error as NSError {
            print("Could not fetch. \(error)")
            return nil
        }
    }
    
    
    func checkById(id: Int) -> Bool? {
        
        guard let appDelegate   = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext      = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<PictureEntity>(entityName: "PictureEntity")
        let idString = "\(id)"
        let predicate = NSPredicate(format: "id == %@", idString)
        fetchRequest.predicate = predicate
        
        do {
            let pictureEntity = try managedContext.fetch(fetchRequest)
            guard let _ = pictureEntity.first else { return false }
            return true
        } catch let error as NSError {
            print("Could not fetch. \(error)")
            return nil
        }
    }
}
