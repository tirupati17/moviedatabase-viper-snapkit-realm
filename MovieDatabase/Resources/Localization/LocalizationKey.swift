//
//  LocalizationKey.swift
//  movieDatabase
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright © 2020 Celerstudio. All rights reserved.
//

import Foundation

enum LocalizationKey {
    
    enum NetworkError: String {
        case DefaultConnectionErrorTitle = "default_connection_error_title"
        case DefaultConnectionErrorDescription = "default_connection_error_description"
        case DefaultConnectionErrorConfirmButton = "default_connection_error_confirm_button"
        case DefaultOKButton = "ok"

        func localizedString() -> String {
            return self.rawValue.localizedString()
        }

    }
    
    enum Home: String {
        case NextButton = "done"
        case NoResultFound = "no_result_found"
        case NA = "na"

        func localizedString() -> String {
            return self.rawValue.localizedString()
        }
        
    }
    
}
