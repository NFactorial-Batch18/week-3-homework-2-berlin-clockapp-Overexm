//
//  TimeConverter.swift
//  BerlinClock
//
//  Created by Merey Orynbassar on 10.05.2022.
//

import Foundation
import SwiftUI

protocol Calculated{
    func calculateMinutes(_ time: Int) -> String
    func lightOrNot(_ time: Int, _ numLight: Int, _ stringValue:String) -> String
    func getHigherValue(_ time: Int) -> Int
    func getLight(_ time: Int,_ numLight: Int) -> String
    func calculateHours(_ time: Int) -> String
    func calculateSeconds(_ time: Int) -> String
    func timeConverter(_ hours: Int, _ minutes: Int,_ seconds: Int) -> String
    func rawBerlin(_ hours: Int, _ minutes: Int,_ seconds: Int) -> String
}

struct berlinClock : Calculated{
    
    func timeConverter(_ hours: Int, _ minutes: Int,_ seconds: Int) -> String{
        
        
        return calculateSeconds(seconds) + " " + calculateHours(hours) + " " + calculateMinutes(minutes)
        
    }
  
    func rawBerlin(_ hours: Int, _ minutes: Int,_ seconds: Int) -> String{
        
        
        return calculateSeconds(seconds) + calculateHours(hours) + calculateMinutes(minutes)
        
    }
    func getLight(_ time: Int, _ numLight: Int ) -> String{
        return lightOrNot(time, numLight, "1")
    }
    
    func getHigherValue(_ time: Int) -> Int {
        let calculate = time % 5
        return (time - calculate) / 5
    }
    
    
    func lightOrNot(_ time: Int, _ numLight: Int, _ stringValue: String) -> String {
        var timeString = ""
        for _ in 0..<time {
                   timeString += stringValue
               }
       
               for _ in 0..<(numLight-time){
                   timeString += "0"
               }
               return timeString
        
    }
    
    
    func calculateMinutes(_ minutes: Int) -> String{
        let minutesInFirst = lightOrNot(getHigherValue(minutes), 11, "1")
        let minutesBottom = lightOrNot(minutes % 5, 4, "1")
        
        return minutesInFirst + minutesBottom
    }
    
    func calculateHours(_ hours: Int) -> String{
        let hoursInFirst = getLight(getHigherValue(hours), 4)
        let hoursBottom = getLight(hours % 5, 4)
        
        return hoursInFirst + hoursBottom
    }
    
    func calculateSeconds(_ seconds: Int) -> String{
    
        let line = seconds % 2 == 0 ? "1":"0"
        return line
        
    }
    
}
