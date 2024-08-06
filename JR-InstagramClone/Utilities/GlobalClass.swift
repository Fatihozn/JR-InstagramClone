//
//  GloballClass.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 30.07.2024.
//

import Foundation
import SwiftUI

final class GlobalClass: ObservableObject {
    
    static let shared = GlobalClass()
    
    init () { }
    
    @Published var User: User?
}
