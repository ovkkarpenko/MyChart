//
//  Chart.swift
//  ChartApp
//
//  Created by Oleksandr Karpenko on 10.12.2020.
//

import Foundation

struct ChartItem {
    
    var value: Int
    
    init(value: Int) {
        if value < 0 || value > 100 { fatalError("the value must be between 0 and 100") }
        
        self.value = value
    }
}
