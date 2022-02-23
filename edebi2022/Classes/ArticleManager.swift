//
//  ArticleManager.swift
//  Pods
//
//  Created by George Tevosov on 18.02.2022.
//

import Foundation
import CoreData

@available(iOS 10.0, *)
public class ArticleManager {
    
    var managedObjectContext: NSManagedObjectContext?
    
    private lazy var container: NSPersistentContainer? =  {
        var container: NSPersistentContainer
        
        let bundle = Bundle(identifier:  "org.cocoapods.edebi2022")
        guard let modelURL = bundle?.url(forResource: "article", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Fail to load the trigger model!: \(modelURL)")
        }
        container = NSPersistentContainer(name: "article", managedObjectModel: model)
        container.loadPersistentStores(completionHandler: {
            (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        })
        return container
    }()
    
    public init?() {
        managedObjectContext = container?.viewContext
        guard managedObjectContext != nil else {
            print("Managed object context errored")
            return nil
        }
    }
    
    public func newArticle() -> Article {
        return NSEntityDescription.insertNewObject(forEntityName: "Article", into: self.managedObjectContext!) as! Article
    }
    
    public func getAllArticles() -> [Article]  {
        return getData()
    }
    
    func getData(pred: NSPredicate? = nil) -> [Article] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        if (pred != nil) {
            request.predicate = pred
        }
        do {
            
            let result = try managedObjectContext?.fetch(request) as! [Article]
            return result
        }
        catch {
            print("failed fetch all");
            return []
        }
    }
    
    public func getArticles(withLang lang: String) -> [Article]
    {
        return getData(pred: NSPredicate(format: "language == %@", lang))
    }
    
    
    public func getArticles(containString str: String) -> [Article]
    {
        return getData(pred: NSPredicate(format: "content contains[c] %@ OR title CONTAINS[c] %@", str, str))
    }
    
    public func removeArticles(article: Article)->Bool
    {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Article")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext?.execute(deleteRequest)
            return true
        } catch {
            print (error)
            return false
        }
    }
    
    public func save() {
        if (managedObjectContext!.hasChanges)
        {
            do {
            try managedObjectContext?.save()
            }
            catch {
                print("error wile saving")
            }
        }
    }
    
    
    
}

