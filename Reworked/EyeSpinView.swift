//
//  EyeSpinView.swift
//
//  Code generated using QuartzCode 1.39.10 on 3/6/16.
//  www.quartzcodeapp.com
//

import UIKit

@IBDesignable
class EyeSpinView: UIView {
	
	var updateLayerValueForCompletedAnimation : Bool = false
	var animationAdded : Bool = false
	var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
	var layers : Dictionary<String, AnyObject> = [:]
	
	var color : UIColor!
	
	//MARK: - Life Cycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupProperties()
		setupLayers()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		setupProperties()
		setupLayers()
	}
	
	var spinAnimProgress: CGFloat = 0{
		didSet{
			if(!self.animationAdded){
				removeAllAnimations()
				addSpinAnimation()
				self.animationAdded = true
				layer.speed = 0
				layer.timeOffset = 0
			}
			else{
				let totalDuration : CGFloat = 1.5
				let offset = spinAnimProgress * totalDuration
				layer.timeOffset = CFTimeInterval(offset)
			}
		}
	}
	
	override var frame: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	override var bounds: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	func setupProperties(){
		self.color = UIColor(red:0.298, green: 0.298, blue:0.298, alpha:1)
	}
	
	func setupLayers(){
		self.backgroundColor = UIColor.whiteColor()
		
		let Group = CALayer()
		self.layer.addSublayer(Group)
		layers["Group"] = Group
		let oval = CAShapeLayer()
		Group.addSublayer(oval)
		layers["oval"] = oval
		let path = CAShapeLayer()
		Group.addSublayer(path)
		layers["path"] = path
		
		resetLayerPropertiesForLayerIdentifiers(nil)
		setupLayerFrames()
	}
	
	func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if layerIds == nil || layerIds.contains("oval"){
			let oval = layers["oval"] as! CAShapeLayer
			oval.fillColor     = UIColor(red:0.4, green: 0.4, blue:0.4, alpha:1).CGColor
			oval.lineWidth     = 0
			oval.shadowColor   = UIColor(red:0, green: 0, blue:0, alpha:0.3).CGColor
			oval.shadowOpacity = 0.3
			oval.shadowOffset  = CGSizeMake(0, 2)
			oval.shadowRadius  = 4
		}
		if layerIds == nil || layerIds.contains("path"){
			let path = layers["path"] as! CAShapeLayer
			path.fillRule        = kCAFillRuleEvenOdd
			path.fillColor       = self.color.CGColor
			path.lineWidth       = 0
			path.lineDashPattern = [4.5, 0]
		}
		
		CATransaction.commit()
	}
	
	func setupLayerFrames(){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if let Group : CALayer = layers["Group"] as? CALayer{
			Group.frame = CGRectMake(0.1109 * Group.superlayer!.bounds.width, 0.26392 * Group.superlayer!.bounds.height, 0.7782 * Group.superlayer!.bounds.width, 0.47216 * Group.superlayer!.bounds.height)
		}
		
		if let oval : CAShapeLayer = layers["oval"] as? CAShapeLayer{
			oval.frame = CGRectMake(0.39341 * oval.superlayer!.bounds.width, 0.32433 * oval.superlayer!.bounds.height, 0.21317 * oval.superlayer!.bounds.width, 0.35135 * oval.superlayer!.bounds.height)
			oval.path  = ovalPathWithBounds((layers["oval"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path : CAShapeLayer = layers["path"] as? CAShapeLayer{
			path.frame = CGRectMake(0, 0, 1 * path.superlayer!.bounds.width,  path.superlayer!.bounds.height)
			path.path  = pathPathWithBounds((layers["path"] as! CAShapeLayer).bounds).CGPath;
		}
		
		CATransaction.commit()
	}
	
	//MARK: - Animation Setup
	
	func addSpinAnimation(){
		resetLayerPropertiesForLayerIdentifiers(["oval", "path"])
		
		self.layer.speed = 1
		self.animationAdded = false
		
		let fillMode : String = kCAFillModeForwards
		
		////An infinity animation
		
		////Oval animation
		let ovalOpacityAnim            = CAKeyframeAnimation(keyPath:"opacity")
		ovalOpacityAnim.values         = [0.7, 1, 0.7, 1, 0.7]
		ovalOpacityAnim.keyTimes       = [0, 0.25, 0.5, 0.75, 1]
		ovalOpacityAnim.duration       = 1.49
		ovalOpacityAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		ovalOpacityAnim.repeatCount    = Float.infinity
		
		let oval = layers["oval"] as! CAShapeLayer
		
		let ovalTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		ovalTransformAnim.values         = [NSValue(CATransform3D: CATransform3DIdentity), 
			 NSValue(CATransform3D: CATransform3DMakeScale(0.5, 0.5, 0.5)), 
			 NSValue(CATransform3D: CATransform3DIdentity)]
		ovalTransformAnim.keyTimes       = [0, 0.5, 1]
		ovalTransformAnim.duration       = 1.49
		ovalTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		ovalTransformAnim.repeatCount    = Float.infinity
		ovalTransformAnim.autoreverses   = true
		
		let ovalSpinAnim : CAAnimationGroup = QCMethod.groupAnimations([ovalOpacityAnim, ovalTransformAnim], fillMode:fillMode)
		oval.addAnimation(ovalSpinAnim, forKey:"ovalSpinAnim")
		
		let path = layers["path"] as! CAShapeLayer
		
		////Path animation
		let pathTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		pathTransformAnim.values         = [NSValue(CATransform3D: CATransform3DIdentity), 
			 NSValue(CATransform3D: CATransform3DMakeRotation(-CGFloat(M_PI_4), 0, 2, 1)), 
			 NSValue(CATransform3D: CATransform3DIdentity), 
			 NSValue(CATransform3D: CATransform3DMakeRotation(45 * CGFloat(M_PI/180), 0, 2, 1)), 
			 NSValue(CATransform3D: CATransform3DIdentity)]
		pathTransformAnim.keyTimes       = [0, 0.25, 0.5, 0.75, 1]
		pathTransformAnim.duration       = 1.49
		pathTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		pathTransformAnim.repeatCount    = Float.infinity
		
		let pathOpacityAnim            = CAKeyframeAnimation(keyPath:"opacity")
		pathOpacityAnim.values         = [0.7, 1, 0.7, 1, 0.7]
		pathOpacityAnim.keyTimes       = [0, 0.25, 0.5, 0.75, 1]
		pathOpacityAnim.duration       = 1.49
		pathOpacityAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		pathOpacityAnim.repeatCount    = Float.infinity
		
		let pathShadowOpacityAnim            = CAKeyframeAnimation(keyPath:"shadowOpacity")
		pathShadowOpacityAnim.values         = [0.33, 0.6, 0.6]
		pathShadowOpacityAnim.duration       = 1.49
		pathShadowOpacityAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		let pathShadowOffsetAnim             = CAKeyframeAnimation(keyPath:"shadowOffset")
		pathShadowOffsetAnim.values          = [NSValue(CGSize: CGSizeMake(0, 0)), 
			NSValue(CGSize: CGSizeMake(0, 2)), 
			NSValue(CGSize: CGSizeMake(0, 2))]
		pathShadowOffsetAnim.duration        = 1.49
		pathShadowOffsetAnim.timingFunction  = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		let pathShadowRadiusAnim             = CAKeyframeAnimation(keyPath:"shadowRadius")
		pathShadowRadiusAnim.values          = [0, 2, 2]
		pathShadowRadiusAnim.duration        = 1.49
		pathShadowRadiusAnim.timingFunction  = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		
		let pathLineWidthAnim            = CAKeyframeAnimation(keyPath:"lineWidth")
		pathLineWidthAnim.values         = [0, 5, 0]
		pathLineWidthAnim.keyTimes       = [0, 0.5, 1]
		pathLineWidthAnim.duration       = 1.49
		pathLineWidthAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		pathLineWidthAnim.repeatCount    = Float.infinity
		pathLineWidthAnim.autoreverses   = true
		
		let pathSpinAnim : CAAnimationGroup = QCMethod.groupAnimations([pathTransformAnim, pathOpacityAnim, pathShadowOpacityAnim, pathShadowOffsetAnim, pathShadowRadiusAnim, pathLineWidthAnim], fillMode:fillMode)
		path.addAnimation(pathSpinAnim, forKey:"pathSpinAnim")
	}
	
	//MARK: - Animation Cleanup
	
	override func animationDidStop(anim: CAAnimation, finished flag: Bool){
		if let completionBlock = completionBlocks[anim]{
			completionBlocks.removeValueForKey(anim)
			if (flag && updateLayerValueForCompletedAnimation) || anim.valueForKey("needEndAnim") as! Bool{
				updateLayerValuesForAnimationId(anim.valueForKey("animId") as! String)
				removeAnimationsForAnimationId(anim.valueForKey("animId") as! String)
			}
			completionBlock(flag)
		}
	}
	
	func updateLayerValuesForAnimationId(identifier: String){
		if identifier == "spin"{
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["oval"] as! CALayer).animationForKey("ovalSpinAnim"), theLayer:(layers["oval"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["path"] as! CALayer).animationForKey("pathSpinAnim"), theLayer:(layers["path"] as! CALayer))
		}
	}
	
	func removeAnimationsForAnimationId(identifier: String){
		if identifier == "spin"{
			(layers["oval"] as! CALayer).removeAnimationForKey("ovalSpinAnim")
			(layers["path"] as! CALayer).removeAnimationForKey("pathSpinAnim")
		}
		self.layer.speed = 1
	}
	
	func removeAllAnimations(){
		for layer in layers.values{
			(layer as! CALayer).removeAllAnimations()
		}
		self.layer.speed = 1
	}
	
	//MARK: - Bezier Path
	
	func ovalPathWithBounds(bound: CGRect) -> UIBezierPath{
		let ovalPath = UIBezierPath(ovalInRect:bound)
		return ovalPath;
	}
	
	func pathPathWithBounds(bound: CGRect) -> UIBezierPath{
		let pathPath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		pathPath.moveToPoint(CGPointMake(minX + 0.50002 * w, minY + -0.01164 * h))
		pathPath.addCurveToPoint(CGPointMake(minX + 0.00004 * w, minY + 0.48836 * h), controlPoint1:CGPointMake(minX + 0.22389 * w, minY + -0.01164 * h), controlPoint2:CGPointMake(minX + 0.00367 * w, minY + 0.48173 * h))
		pathPath.addCurveToPoint(CGPointMake(minX + 0.50002 * w, minY + 0.98836 * h), controlPoint1:CGPointMake(minX + -0.00359 * w, minY + 0.49499 * h), controlPoint2:CGPointMake(minX + 0.22389 * w, minY + 0.98836 * h))
		pathPath.addCurveToPoint(CGPointMake(minX + 1 * w, minY + 0.48836 * h), controlPoint1:CGPointMake(minX + 0.77615 * w, minY + 0.98836 * h), controlPoint2:CGPointMake(minX + 1.00056 * w, minY + 0.48443 * h))
		pathPath.addCurveToPoint(CGPointMake(minX + 0.50002 * w, minY + -0.01164 * h), controlPoint1:CGPointMake(minX + 0.99944 * w, minY + 0.4923 * h), controlPoint2:CGPointMake(minX + 0.77615 * w, minY + -0.01164 * h))
		pathPath.closePath()
		pathPath.moveToPoint(CGPointMake(minX + 0.50002 * w, minY + 0.0935 * h))
		pathPath.addCurveToPoint(CGPointMake(minX + 0.10918 * w, minY + 0.48724 * h), controlPoint1:CGPointMake(minX + 0.28306 * w, minY + 0.0935 * h), controlPoint2:CGPointMake(minX + 0.10809 * w, minY + 0.49474 * h))
		pathPath.addCurveToPoint(CGPointMake(minX + 0.50002 * w, minY + 0.88322 * h), controlPoint1:CGPointMake(minX + 0.11028 * w, minY + 0.47973 * h), controlPoint2:CGPointMake(minX + 0.28306 * w, minY + 0.88322 * h))
		pathPath.addCurveToPoint(CGPointMake(minX + 0.89287 * w, minY + 0.48836 * h), controlPoint1:CGPointMake(minX + 0.71699 * w, minY + 0.88322 * h), controlPoint2:CGPointMake(minX + 0.89086 * w, minY + 0.48412 * h))
		pathPath.addCurveToPoint(CGPointMake(minX + 0.50002 * w, minY + 0.0935 * h), controlPoint1:CGPointMake(minX + 0.89488 * w, minY + 0.4926 * h), controlPoint2:CGPointMake(minX + 0.71699 * w, minY + 0.0935 * h))
		pathPath.closePath()
		pathPath.moveToPoint(CGPointMake(minX + 0.50002 * w, minY + 0.0935 * h))
		
		return pathPath;
	}
	
	
}
