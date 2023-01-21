//
//  Vakitler.swift
//  Namaz
//
//  Created by Kıvanç Bozkuş on 30.08.2021.
//

import Foundation
import Adhan
import CoreLocation
import Combine
var koorlat:Double = 0.0
var koorlong:Double = 0.0
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        //print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        koorlat = lastLocation!.coordinate.latitude
        koorlong = lastLocation!.coordinate.longitude
        //print(#function, location)
    }
}
func hesap() -> String {
    let cal = Calendar(identifier: Calendar.Identifier.gregorian)
    let date = cal.dateComponents([.year, .month, .day], from: Date())
    var params = CalculationMethod.turkey.params
    params.madhab = .shafi
    var sonuc = ""
    
    if let prayers = PrayerTimes(coordinates: Coordinates(latitude: koorlat, longitude: koorlong), date: date, calculationParameters: params) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: "Turkey")!
        
        if prayers.fajr.timeIntervalSince(Date()) > 0 {
        let kalan = prayers.fajr.timeIntervalSince(Date())
        let kalansaat = Int(kalan/3600)
        let kalansn = Int(kalan)-kalansaat*3600
        let kalandk = Int(kalansn/60)
        sonuc = "İmsak:   \(formatter.string(from: prayers.fajr)) \n" + "Güneş:  \(formatter.string(from: prayers.sunrise)) \n" + "Öğle:     \(formatter.string(from: prayers.dhuhr)) \n" + "İkindi:    \(formatter.string(from: prayers.asr)) \n" + "Akşam:  \(formatter.string(from: prayers.maghrib)) \n" + "Yatsı:     \(formatter.string(from: prayers.isha)) \n" + "Kalan:    " + String(kalansaat) + ":" + String(kalandk)
    } else if prayers.sunrise.timeIntervalSince(Date()) > 0 {
        let kalan = prayers.sunrise.timeIntervalSince(Date())
        let kalansaat = Int(kalan/3600)
        let kalansn = Int(kalan)-kalansaat*3600
        let kalandk = Int(kalansn/60)
        sonuc = "İmsak:   \(formatter.string(from: prayers.fajr)) \n" + "Güneş:  \(formatter.string(from: prayers.sunrise)) \n" + "Öğle:     \(formatter.string(from: prayers.dhuhr)) \n" + "İkindi:    \(formatter.string(from: prayers.asr)) \n" + "Akşam:  \(formatter.string(from: prayers.maghrib)) \n" + "Yatsı:     \(formatter.string(from: prayers.isha)) \n" + "Kalan:    " + String(kalansaat) + ":" + String(kalandk)
    } else if prayers.dhuhr.timeIntervalSince(Date()) > 0 {
        let kalan = prayers.dhuhr.timeIntervalSince(Date())
        let kalansaat = Int(kalan/3600)
        let kalansn = Int(kalan)-kalansaat*3600
        let kalandk = Int(kalansn/60)
        sonuc = "İmsak:   \(formatter.string(from: prayers.fajr)) \n" + "Güneş:  \(formatter.string(from: prayers.sunrise)) \n" + "Öğle:     \(formatter.string(from: prayers.dhuhr)) \n" + "İkindi:    \(formatter.string(from: prayers.asr)) \n" + "Akşam:  \(formatter.string(from: prayers.maghrib)) \n" + "Yatsı:     \(formatter.string(from: prayers.isha)) \n" + "Kalan:    " + String(kalansaat) + ":" + String(kalandk)
    } else if prayers.asr.timeIntervalSince(Date()) > 0 {
        let kalan = prayers.asr.timeIntervalSince(Date())
        let kalansaat = Int(kalan/3600)
        let kalansn = Int(kalan)-kalansaat*3600
        let kalandk = Int(kalansn/60)
        sonuc = "İmsak:   \(formatter.string(from: prayers.fajr)) \n" + "Güneş:  \(formatter.string(from: prayers.sunrise)) \n" + "Öğle:     \(formatter.string(from: prayers.dhuhr)) \n" + "İkindi:    \(formatter.string(from: prayers.asr)) \n" + "Akşam:  \(formatter.string(from: prayers.maghrib)) \n" + "Yatsı:     \(formatter.string(from: prayers.isha)) \n" + "Kalan:    " + String(kalansaat) + ":" + String(kalandk)
    } else if prayers.maghrib.timeIntervalSince(Date()) > 0 {
        let kalan = prayers.maghrib.timeIntervalSince(Date())
        let kalansaat = Int(kalan/3600)
        let kalansn = Int(kalan)-kalansaat*3600
        let kalandk = Int(kalansn/60)
        sonuc = "İmsak:   \(formatter.string(from: prayers.fajr)) \n" + "Güneş:  \(formatter.string(from: prayers.sunrise)) \n" + "Öğle:     \(formatter.string(from: prayers.dhuhr)) \n" + "İkindi:    \(formatter.string(from: prayers.asr)) \n" + "Akşam:  \(formatter.string(from: prayers.maghrib)) \n" + "Yatsı:     \(formatter.string(from: prayers.isha)) \n" + "Kalan:    " + String(kalansaat) + ":" + String(kalandk)
    } else if prayers.isha.timeIntervalSince(Date()) > 0 {
        let kalan = prayers.isha.timeIntervalSince(Date())
        let kalansaat = Int(kalan/3600)
        let kalansn = Int(kalan)-kalansaat*3600
        let kalandk = Int(kalansn/60)
        sonuc = "İmsak:   \(formatter.string(from: prayers.fajr)) \n" + "Güneş:  \(formatter.string(from: prayers.sunrise)) \n" + "Öğle:     \(formatter.string(from: prayers.dhuhr)) \n" + "İkindi:    \(formatter.string(from: prayers.asr)) \n" + "Akşam:  \(formatter.string(from: prayers.maghrib)) \n" + "Yatsı:     \(formatter.string(from: prayers.isha)) \n" + "Kalan:    " + String(kalansaat) + ":" + String(kalandk)
    } else {
        sonuc = "İmsak:   \(formatter.string(from: prayers.fajr)) \n" + "Güneş:  \(formatter.string(from: prayers.sunrise)) \n" + "Öğle:     \(formatter.string(from: prayers.dhuhr)) \n" + "İkindi:    \(formatter.string(from: prayers.asr)) \n" + "Akşam:  \(formatter.string(from: prayers.maghrib)) \n" + "Yatsı:     \(formatter.string(from: prayers.isha))"
        
    }
    }
    return sonuc
}
