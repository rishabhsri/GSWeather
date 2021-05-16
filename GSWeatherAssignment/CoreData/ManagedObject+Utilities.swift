//
//  ManagedObject+Utilities.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 14/05/21.
//

import Foundation
import CoreData

extension NSManagedObject
{
    static internal func newObjectInManagedObjectContext(_ context:NSManagedObjectContext?, className:String) -> AnyObject?
    {
        guard let contextObj = context else {
            return nil
        }
        
        return NSEntityDescription.insertNewObject(forEntityName: className, into: contextObj)
    }
    
    static internal func saveContext(_ context:NSManagedObjectContext) -> Void
    {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    @nonobjc class internal var className: String{
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}

