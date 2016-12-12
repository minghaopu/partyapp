//
//  MapAnnotations.swift
//  PartyApp
//
//  Created by XYZ on 2016/12/12.
//  Copyright © 2016年 CSCI-6907-Minghao Pu. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotations: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
