//
//  CalendarViewModel.swift
//  Lesson9_Calendar
//
//  Created by Pavel Ivanov on 4/5/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation

class CalendarViewModel {
    
    let dataSource = CalendarDataSource()
    
    func numberOfSection() -> Int {
        
        return dataSource.numberOfMonth()
    }    
    
    
    func titleOfMonth(for section: Int) -> String {
        
       return dataSource.titleOfMonth(for: section)
       
    }
    
    func numberOfRows(for section: Int, year: Int) -> Int {
        let month = section + 1
        return dataSource.numberOfDaysInMonth(for: month, year: year)
        
    }
    
    func numberOfPrewDay(for section: Int, year: Int) -> Int {
        let month = section + 1
        return dataSource.numberOfPrevDaysInMonth(for: month, year: year)
        
    }
    
}
