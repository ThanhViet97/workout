//
//  GlobalFunction.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

func resolve<Service>(_ serviceType: Service.Type) -> Service {
    return appDelegate.diService.resolve(serviceType)
}
