//
//  ContentView.swift
//  BerlinClock
//
//  Created by Merey Orynbassar on 10.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State var timing: [String] = []
    @State private var date = Date()
    @State var currentTime: String = ""
    var body: some View {
        ZStack{
            AppColors.background
                .ignoresSafeArea()
            VStack{
                if (timing.count > 0){
                Text("This is  \(currentTime)")
                    .font(.system(size: 17, weight: .semibold, design: .default))
                main
                
                ZStack{
                    DateFrame()
                    HStack{
                        DatePicker("Insert time", selection: $date, displayedComponents: .hourAndMinute)
                            .onChange(of: date, perform: { newValue in
                                showBerlinTime()
                            })
                            .environment(\.locale, Locale(identifier: "ru-RU"))
                            .padding(.horizontal,16)
                            .frame(width:358, height: 54)
                        
                    }
                }
                }
                Spacer()
            }.onAppear(){
                showBerlinTime()
            }
        }
    }
    
    var main: some View{
        ZStack{
            FrameSection()
            VStack(spacing:16){
                Circle()
                    .fill(timing[0] == "1" ? AppColors.yellowColor : AppColors.lightYellow )
                    .frame(width:56, height:56)
                
                Hours(timing: $timing)
                SingleHours(timing: $timing)
                Minutes(timing: $timing)
                SingleMinutes(timing: $timing)
                
                
            }
        }
    }
    
    func showBerlinTime(){
        let date = date
                    let calendar = Calendar.current
                    let seconds = calendar.component(.second, from: date)
                    let minutes = calendar.component(.minute, from: date)
                    let hours = calendar.component(.hour, from: date)
                    let berlinClock = berlinClock()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm:ss"
                    currentTime = formatter.string(from: date)
                    timing = berlinClock.rawBerlin(hours, minutes, seconds).map{String($0)}
                    print(berlinClock.timeConverter(hours, minutes, seconds))
    }
}



struct Hours: View{
    @Binding var timing: [String]
    var body: some View{
        HStack(spacing:10){
            ForEach(1..<5){ i in
                RoundedRectangle(cornerRadius: 4)
                    .fill(timing[i] == "1" ? AppColors.redColor : AppColors.lightRed)
                    .frame(width:74, height: 32 )
                
            }
           
            
        }
    }
}

struct SingleHours: View{
    @Binding var timing: [String]
    var body: some View{
        HStack(spacing:10){
            ForEach(5..<9){ i in
                RoundedRectangle(cornerRadius: 4)
                    .fill(timing[i] == "1" ? AppColors.redColor : AppColors.lightRed)
                    .frame(width:74, height: 32 )
            }
        }
    }
}

struct Minutes: View{
    @Binding var timing: [String]
    var body: some View{
        HStack(spacing:10){
            ForEach(9..<20){ i in
                RoundedRectangle(cornerRadius: 4)
                    .fill(timing[i] == "1" ? AppColors.yellowColor : AppColors.lightYellow)
                    .frame(width:21, height: 32 )
            }
        }
    }
}

struct SingleMinutes: View{
    @Binding var timing: [String]
    var body: some View{
        HStack(spacing:10){
            ForEach(20..<24){ i in
                RoundedRectangle(cornerRadius: 4)
                    .fill(timing[i] == "1" ? AppColors.yellowColor : AppColors.lightYellow)
                    .frame(width:74, height: 32 )
            }
        }
    }
}

struct FrameSection: View{
    var body: some View{
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .frame(width:358, height: 312 )
    }
}

struct DateFrame: View{
    var body: some View{
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .frame(width:358, height: 54 )
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
