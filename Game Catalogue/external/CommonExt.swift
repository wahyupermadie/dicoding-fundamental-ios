//
//  CommonExt.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 14/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)!
        return date
    }
}

extension Date {
    func convertToString(format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
