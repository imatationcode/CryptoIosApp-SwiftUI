//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by shivakumar Harijan on 18/07/25.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let persistentContainer: NSPersistentContainer
    private let persistentContainerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        persistentContainer = NSPersistentContainer(name: persistentContainerName)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Error while loading Core Data! \(error)")
            }
            self.getPortfolioData()
        }
    }
    
    //MARK: PUBLIC
    func updatePortfolioData(coin: CoinModal, amount: Double) {
        //check if coin already exists
        if let entity = savedEntities.first(where: { (savedEntity) -> Bool in
            return savedEntity.coinID == coin.id}) {
            if amount > 0 {
                updateCoin(entity: entity, amount: amount)
            } else {
                deleteCoin(entity: entity)
            }
        } else {
            addCoin(coin: coin, amount: amount)
        }
    }
    
    // MARK: PRIVATE
    
    private func getPortfolioData() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error while fetching data form CoreDat ! \(error)")
        }
    }
    
    private func addCoin(coin: CoinModal, amount: Double) {
        let entity = PortfolioEntity(context: persistentContainer.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChnages()
    }
    
    private func updateCoin(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChnages()
    }
    
    private func deleteCoin(entity: PortfolioEntity) {
        persistentContainer.viewContext.delete(entity)
        applyChnages()
    }
    private func saveCoin() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Error while saving data to CoreData ! \(error)")
        }
    }
    
    private func applyChnages() {
        saveCoin()
        getPortfolioData()
    }
}
