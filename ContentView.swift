//
//  ContentView.swift
//  Namaz
//
//  Created by Kıvanç Bozkuş on 30.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeNow = ""
    let dateFormatter = DateFormatter()
    @StateObject var locationManager = LocationManager()
    var userLatitude: Double {return (locationManager.lastLocation?.coordinate.latitude ?? 0)}
    var userLongitude: String {return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"}
  
  var body: some View {
      VStack {
        Text("Minimal Namaz Vakti")
            .font(.title)
         // Text("location status: \(locationManager.statusString)")
         Text("Enlem: \(userLatitude)")
         Text("Boylam: \(userLongitude)")
         //Text(Date(), style: .time)
         Text(timeNow)
                .onReceive(timer) { _ in
                self.timeNow = dateFormatter.string(from: Date())
                }
                .onAppear(perform: {dateFormatter.dateFormat = " HH:mm:ss"})
         Text(hesap())
      }.padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
