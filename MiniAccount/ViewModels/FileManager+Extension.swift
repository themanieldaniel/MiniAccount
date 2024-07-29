//
//  FileManager+Extension.swift
//  MiniAccount
//
//  Created by Daniel on 7/26/24.
//


import Foundation

extension FileManager {
    static var iCloudContainerURL: URL? {
        return FileManager.default.url(forUbiquityContainerIdentifier: nil)
    }

    static var choresURL: URL {
        guard let iCloudURL = iCloudContainerURL else {
            fatalError("iCloud not available")
        }
        return iCloudURL.appendingPathComponent("Documents/chores.json")
    }

    static var transactionsURL: URL {
        guard let iCloudURL = iCloudContainerURL else {
            fatalError("iCloud not available")
        }
        return iCloudURL.appendingPathComponent("Documents/transactions.json")
    }
}
