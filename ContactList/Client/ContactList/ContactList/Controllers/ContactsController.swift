//
//  ContactsController.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/11/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import CoreData
import Foundation

enum ContactsControllerError: Error {
    case parsing
}

typealias FetchItemsCompletionBlock = (_ success: Bool, _ error: Error?) -> Void

// MARK: - ContactsControllerProtocol

protocol ContactsControllerProtocol {
    var items: [ContactViewModel?]? { get }
    var itemCount: Int { get }

    func item(at index: Int) -> ContactViewModel?
    func fetchItems(_ completionBlock: @escaping FetchItemsCompletionBlock)
}

extension ContactsControllerProtocol {
    var items: [ContactViewModel?]? {
        return items
    }

    var itemCount: Int {
        return items?.count ?? 0
    }
    
    func item(at index: Int) -> ContactViewModel? {
        guard index >= 0 && index < itemCount else { return nil }
        return items?[index] ?? nil
    }
}

// MARK: - ContactsController

class ContactsController: ContactsControllerProtocol {
    private static let entityName = "User"
    
    private let persistentContainer: NSPersistentContainer
    
    private var fetchItemsCompletionBlock: FetchItemsCompletionBlock?

    var items: [ContactViewModel?]? = []
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func fetchItems(_ completionBlock: @escaping FetchItemsCompletionBlock) {
        let urlString = String(format: "http://localhost:5000/contacts")
        guard let url = URL(string: urlString) else {
            fetchItemsCompletionBlock?(false, nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard let jsonData = data, error == nil else {
                DispatchQueue.main.async {
                    self.fetchItemsCompletionBlock?(false, error as NSError?)
                }
                return
            }
            if self.parse(jsonData) {
//                if let users = self.fetchFromStorage() {
//                    let newUsersPage = ContactsController.initViewModels(users)
//                    self.items?.append(contentsOf: newUsersPage)
//                }
//                DispatchQueue.main.async {
//                    self.fetchItemsCompletionBlock?(true, nil)
//                }
            } else {
                DispatchQueue.main.async {
                    self.fetchItemsCompletionBlock?(false, ContactsControllerError.parsing)
                }
            }
        }
        task.resume()
    }
    
    func item(at index: Int) -> ContactViewModel? {
        guard index >= 0 && index < itemCount else { return nil }
        return items?[index] ?? nil
    }
}

private extension ContactsController {
    func parse(_ jsonData: Data) -> Bool {
        do {
            let contacts = try Contact.decode(from: jsonData)
            return true
        } catch {
            print("Failed to decode contacts: \(error.localizedDescription)")
            return false
        }
    }
    
//    func fetchFromStorage() -> [Contact]? {
//        let managedObjectContext = persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<Contact>(entityName: UserController.entityName)
//        let sortDescriptor1 = NSSortDescriptor(key: "role", ascending: true)
//        let sortDescriptor2 = NSSortDescriptor(key: "username", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
//        do {
//            let users = try managedObjectContext.fetch(fetchRequest)
//            return users
//        } catch let error {
//            print(error)
//            return nil
//        }
//    }
//
//    func clearStorage() {
//        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
//            return $0 ? true : $1.type == NSInMemoryStoreType
//        }
//
//        let managedObjectContext = persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: UserController.entityName)
//        // NSBatchDeleteRequest is not supported for in-memory stores
//        if isInMemoryStore {
//            do {
//                let users = try managedObjectContext.fetch(fetchRequest)
//                for user in users {
//                    managedObjectContext.delete(user as! NSManagedObject)
//                }
//            } catch let error as NSError {
//                print(error)
//            }
//        } else {
//            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//            do {
//                try managedObjectContext.execute(batchDeleteRequest)
//            } catch let error as NSError {
//                print(error)
//            }
//        }
//    }
    
    static func initViewModels(_ contacts: [Contact?]) -> [ContactViewModel?] {
        return contacts.map { contact in
            if let contact = contact {
                return ContactViewModel(contact: contact)
            } else {
                return nil
            }
        }
    }
}
