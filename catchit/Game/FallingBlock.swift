import UIKit
import SpriteKit

enum FallingBlock: CaseIterable {
    
    case point, poison, health, damage
    
    var nodeName: String {
        switch self {
        case .point: return "PointBlock"
        case .poison: return "PoisonBlock"
        case .health: return "HealthBlock"
        case .damage: return "DamageBlock"
        }
    }
    
    var color: UIColor {
        switch self {
        case .point: return UIColor(named: "PointBlock")!
        case .poison: return UIColor(named: "PoisonBlock")!
        case .health: return UIColor(named: "HealthBlock")!
        case .damage: return UIColor(named: "DamageBlock")!
        }
    }
    
    var frequency: TimeInterval {
        switch self {
        case .point: return Double.random(in: 0.5 ... 1)
        case .poison: return Double.random(in: 3 ... 5)
        case .health: return Double.random(in: 1 ... 3)
        case .damage: return Double.random(in: 0.25 ... 0.5)
        }
    }
}
