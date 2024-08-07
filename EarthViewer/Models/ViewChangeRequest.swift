//
//  ViewChangeRequest.swift
//  EarthViewer
//
//  Created by Alex Persian on 8/7/24.
//

import Foundation

enum ViewChangeRequest {
    case advance
    case rewind
    case to(id: String)
    case random
}
