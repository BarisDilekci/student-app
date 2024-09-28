//
//  Client.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import Foundation

final class Client: GenericAPI {
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    convenience init() {
        self.init(session: URLSession(configuration: .default))
    }
}
