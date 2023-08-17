import UIKit
import SpriteKit

enum FallingBlock: CaseIterable {
    
    case point, health, damage, poison
    
    var nodeName: String {
        switch self {
        case .point: return "PointBlock"
        case .health: return "HealthBlock"
        case .damage: return "DamageBlock"
        case .poison: return "PoisonBlock"
        }
    }
    
    var color: UIColor {
        switch self {
        case .point: return .pointBlock
        case .health: return .healthBlock
        case .damage: return .damageBlock
        case .poison: return .poisonBlock
        }
    }
    
    var spawnFrequency: TimeInterval {
        switch self {
        case .point: return Double.random(in: 0.5 ... 1)
        case .health: return Double.random(in: 1 ... 3)
        case .damage: return Double.random(in: 0.25 ... 0.5)
        case .poison: return Double.random(in: 3 ... 5)
        }
    }
    
    var description: String {
        switch self {
        case .point: return "+1 point"
        case .health: return "+1 heart"
        case .damage: return "-1 heart"
        case .poison: return "0 hearts"
        }
    }
}
