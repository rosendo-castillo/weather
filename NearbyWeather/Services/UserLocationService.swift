//
//  LocationService.swift
//  NearbyWeather
//
//  Created by Erik Maximilian Martens on 09.04.17.
//  Copyright © 2017 Erik Maximilian Martens. All rights reserved.
//

import CoreLocation

final class UserLocationService: CLLocationManager, CLLocationManagerDelegate {
  
  // MARK: - Public Assets
  
  static var shared: UserLocationService!
  
  var currentLatitude: Double?
  var currentLongitude: Double?
  var status : CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
  }
  
  // MARK: - Intialization
  
  private override init() {
    super.init()
  }
  
  // MARK: - Public Methods
  
  static func instantiateSharedInstance() {
    // initialize with example data
    shared = UserLocationService()
    
    UserLocationService.shared.delegate = UserLocationService.shared
    UserLocationService.shared.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    UserLocationService.shared.startUpdatingLocation()
  }
  
  var locationPermissionsGranted: Bool {
    return status == .authorizedAlways || status == .authorizedWhenInUse
  }
  
  var currentLocation: CLLocation? {
    if let latitude = currentLatitude, let longitude = currentLongitude {
      return CLLocation(latitude: latitude, longitude: longitude)
    }
    return nil
  }
  
  // MARK: - Delegate Methods
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
    if status != .authorizedWhenInUse && status != .authorizedAlways {
      self.currentLatitude = nil
      self.currentLongitude = nil
    }
    NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Keys.NotificationCenter.kLocationAuthorizationUpdated),
                                    object: nil)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let currentLocation = manager.location?.coordinate
    currentLatitude = currentLocation?.latitude
    currentLongitude = currentLocation?.longitude
  }
}

