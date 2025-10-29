//
//  SkillModel.swift
//  portfolio
//
//  Created by Yusef Gonzalez on 27/10/25.
//

import Foundation


struct Skill: Identifiable, Hashable {
    let id = UUID()
    let category: String
    let title: String
    let subtitle: String
    let description: String
    let iconName: String
    let progress: Double? // 0.0 - 1.0 (optional)
}
