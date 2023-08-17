import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Properties
    
    @Binding private var score: Int
    @Binding private var hearts: Int
    private let startTime: Date
    
    private let player = SKShapeNode(
        rect: CGRect(x: -32, y: -32, width: 64, height: 64),
        cornerRadius: 8
    )
    private var fallingBlockSpeed = 500
    
    // MARK: - Initialization
    
    init(
        size: CGSize,
        score: Binding<Int>,
        hearts: Binding<Int>,
        startTime: Date
    ) {
        self._score = score
        self._hearts = hearts
        self.startTime = startTime
        
        super.init(size: size)
        
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        self._score = .constant(0)
        self._hearts = .constant(4)
        self.startTime = Date()
        super.init(coder: aDecoder)
    }
    
    // MARK: - SKScene
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        createPlatform()
        createPlayer()
        
        FallingBlock.allCases.forEach { fallingBlock in
            run(
                .repeatForever(
                    .sequence(
                        [
                            .wait(forDuration: fallingBlock.spawnFrequency),
                            .run { self.generate(fallingBlock: fallingBlock) }
                        ]
                    )
                )
            )
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, hearts > 0 else { return }
        
        let location = touch.location(in: self)
        player.position.x = location.x
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.alpha = hearts > 0 ? 1 : 0.24
        
        let secondsElapsed = Int(abs(startTime.timeIntervalSinceNow))
        fallingBlockSpeed = 500 + (secondsElapsed * 10)
        
        let fallenBlocks = self.children.filter { node in
            FallingBlock.allCases.map(\.nodeName).contains(node.name ?? "") &&
            node.position.y <= 0
        }
        fallenBlocks.forEach { $0.removeFromParent() }
    }
    
    // MARK: - SKPhysicsContactDelegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else {
            playerCollided(with: nodeA)
        }
    }
    
    // MARK: - Private Functionality
    
    private func createPlatform() {
        let platform = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width, height: 64))
        platform.fillColor = .init(white: 0.98, alpha: 1.0)
        platform.zPosition = 2
        
        addChild(platform)
    }
    
    private func createPlayer() {
        player.name = "PlayerBlock"
        player.fillColor = .accent
        player.strokeColor = .clear
        player.position = CGPoint(x: self.size.width / 2, y: 96)
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.affectedByGravity = false
        
        addChild(player)
    }
    
    private func generate(fallingBlock: FallingBlock) {
        if hearts == 4 && fallingBlock == .health {
            return
        }
        if hearts == 1 && fallingBlock == .poison {
            return
        }
        if hearts <= 0 {
            return
        }
        
        let rect = CGRect(x: -12, y: -12, width: 24, height: 24)
        let node = SKShapeNode(rect: rect, cornerRadius: 4)
        node.fillColor = fallingBlock.color
        node.strokeColor = .clear
        node.name = fallingBlock.nodeName
        node.position = CGPoint(
            x: CGFloat.random(in: 32 ... (self.size.width - 32)),
            y: self.size.height
        )
        node.zPosition = 1
        node.physicsBody = SKPhysicsBody(rectangleOf: rect.size)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.linearDamping = 0
        node.physicsBody?.categoryBitMask = 0
        node.physicsBody?.contactTestBitMask = 1
        node.physicsBody?.velocity = CGVector(dx: 0, dy: -fallingBlockSpeed)
        
        addChild(node)
    }
    
    private func playerCollided(with node: SKNode) {
        node.removeFromParent()
        
        guard hearts > 0 else {
            return
        }
        
        switch node.name {
        case FallingBlock.point.nodeName:
            score += 1
        case FallingBlock.damage.nodeName:
            hearts -= 1
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: 0.5)
        case FallingBlock.poison.nodeName:
            hearts = 0
        case FallingBlock.health.nodeName:
            if hearts < 4 {
                hearts += 1
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
        default:
            return
        }
    }
}
