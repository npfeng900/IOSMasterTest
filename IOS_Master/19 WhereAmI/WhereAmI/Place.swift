//
//  Place.swift
//  WhereAmI
//
//  Created by Niu Panfeng on 23/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import Foundation
import MapKit

class Place : NSObject, MKAnnotation {
    let title:String?
    let subtitle:String?
    var coordinate:CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
