//
//  LanguageManager.swift
//  GymondoAssessment
//
//  Created by psagc on 25/01/24.
//

import Foundation
import Gymondo

public class LanguageManager {
    
    /// The default LanguageManager
    public static let `default`: LanguageManager = .init()
    
    // Notification used for broadcasting theme changes
    private static let notificationName = Notification.Name("LanguageManager.LanguageChangedNotification")

    // NotificationCenter used for broadcasting theme changes
    private var notificationCenter: NotificationCenter = .init()
    
    
    var language: Exercise.Language = .english
    
   
}
