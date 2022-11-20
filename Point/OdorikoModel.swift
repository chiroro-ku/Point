//
//  OdorikoModel.swift
//  Point
//
//  Created by 小林千浩 on 2022/11/19.
//

import Foundation
import UIKit

class OdorikoModel{
    
    var face: BoneView
    var body: BoneView
    var rightUpperArm: BoneView
    var rightArm: BoneView
    var leftUpperArm: BoneView
    var leftArm: BoneView
    var rightUpperLeg: BoneView
    var rightLeg: BoneView
    var leftUpperLeg: BoneView
    var leftLeg: BoneView
    
    var color: UIColor = .green
    
    var faceSize = CGSize(width: 55, height: 55)
    var boneSize = CGSize(width: 20, height: 60)
    var bodySize = CGSize(width: 60, height: 120)
    
    init(facePoint: CGPoint){
        
        self.face = BoneView(frame: CGRect(origin: facePoint, size: faceSize), color: color)
        self.body = BoneView(frame: CGRect(origin: CGPoint(x: face.frame.width/2, y: face.frame.height), size: bodySize), color: color)
        self.rightUpperArm = BoneView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: boneSize), color: color)
        self.rightArm = BoneView(frame: CGRect(origin: CGPoint(x: rightUpperArm.frame.width/2, y: rightUpperArm.frame.height), size: boneSize), color: color)
        self.leftUpperArm = BoneView(frame: CGRect(origin: CGPoint(x: body.frame.width, y: 0), size: boneSize), color: color)
        self.leftArm = BoneView(frame: CGRect(origin: CGPoint(x: leftUpperArm.frame.width/2, y: rightUpperArm.frame.height), size: boneSize), color: color)
        self.rightUpperLeg = BoneView(frame: CGRect(origin: CGPoint(x: boneSize.width/2, y: bodySize.height), size: boneSize), color: color)
        self.rightLeg = BoneView(frame: CGRect(origin: CGPoint(x: rightUpperLeg.frame.width/2, y: rightUpperLeg.frame.height), size: boneSize), color: color)
        self.leftUpperLeg = BoneView(frame: CGRect(origin: CGPoint(x: body.frame.width-boneSize.width/2, y: body.frame.height), size: boneSize), color: color)
        self.leftLeg = BoneView(frame: CGRect(origin: CGPoint(x: leftUpperLeg.frame.width/2, y: leftUpperLeg.frame.height), size: boneSize), color: color)
        
        self.face.layer.cornerRadius = face.frame.width/2
        self.face.addSubview(body)
        self.body.addSubview(rightUpperArm)
        self.rightUpperArm.addSubview(rightArm)
        self.body.addSubview(leftUpperArm)
        self.leftUpperArm.addSubview(leftArm)
        self.body.addSubview(rightUpperLeg)
        self.rightUpperLeg.addSubview(rightLeg)
        self.body.addSubview(leftUpperLeg)
        self.leftUpperLeg.addSubview(leftLeg)
    }
}
