//
//  CoreDataManager.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 21.12.2023.
//

import UIKit
import CoreData

public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context:NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func createOrderProduct(product: Product) {
        guard let productEntityDescription = NSEntityDescription.entity(forEntityName: "CDProduct", in: context) else { return }
        let CDproduct = CDProduct(entity: productEntityDescription, insertInto: context)
        CDproduct.id = Int16(product.id)
        CDproduct.category = Int16(product.category)
        CDproduct.descriptions = product.description
        CDproduct.image = product.image
        CDproduct.price = product.price
        CDproduct.quantity = Int16(product.quantity)
        CDproduct.title = product.title
        print("Да вроде сохранился")
        
        appDelegate.saveContext()
        
    }
    
    func fetchProducts() -> [CDProduct] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDProduct")
        do {
            return try context.fetch(fetchRequest) as! [CDProduct]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func updateProducts(with id: Int, newQuantity: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDProduct")
        do {
            guard let products = try context.fetch(fetchRequest) as? [CDProduct],
                  let product = products.first(where: {$0.id == id}) else {fatalError("Упали при обновлении данных продукта")}
            product.quantity = Int16(newQuantity)
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    func deleteAllProducts() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDProduct")
        do {
            let products = try context.fetch(fetchRequest) as? [CDProduct]
            products?.forEach {context.delete($0)}
        } catch {
            fatalError("Упали при удалении всех фото")
        }
        appDelegate.saveContext()
    }
    
    func deleteProduct(with id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDProduct")
        do {
            guard let products = try context.fetch(fetchRequest) as? [CDProduct],
                  let product = products.first(where: {$0.id == id}) else {fatalError("Упали при обновлении данных продукта")}
            context.delete(product)
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    
    
    
    
}
