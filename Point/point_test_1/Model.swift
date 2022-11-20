//
//  Model.swift
//  picto_test_5
//
//  Created by 小林千浩 on 2022/11/01.
//

import Foundation

class Model{
    
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
    
    init(facePoint: CGPoint, faceSize: CGSize = CGSize(width: 60, height: 60), bodySize: CGSize = CGSize(width: 80, height: 160), boneSize: CGSize = CGSize(width: 30, height: 100)){
        
        self.face = BoneView(frame: CGRect(origin: facePoint, size: faceSize))
        self.body = BoneView(frame: CGRect(origin: CGPoint(x: face.frame.width/2, y: face.frame.height), size: bodySize))
        self.rightUpperArm = BoneView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: boneSize))
        self.rightArm = BoneView(frame: CGRect(origin: CGPoint(x: rightUpperArm.frame.width/2, y: rightUpperArm.frame.height), size: boneSize))
        self.leftUpperArm = BoneView(frame: CGRect(origin: CGPoint(x: body.frame.width, y: 0), size: boneSize))
        self.leftArm = BoneView(frame: CGRect(origin: CGPoint(x: leftUpperArm.frame.width/2, y: rightUpperArm.frame.height), size: boneSize))
        self.rightUpperLeg = BoneView(frame: CGRect(origin: CGPoint(x: boneSize.width/2, y: bodySize.height), size: boneSize))
        self.rightLeg = BoneView(frame: CGRect(origin: CGPoint(x: rightUpperLeg.frame.width/2, y: rightUpperLeg.frame.height), size: boneSize))
        self.leftUpperLeg = BoneView(frame: CGRect(origin: CGPoint(x: body.frame.width-boneSize.width/2, y: body.frame.height), size: boneSize))
        self.leftLeg = BoneView(frame: CGRect(origin: CGPoint(x: leftUpperLeg.frame.width/2, y: leftUpperLeg.frame.height), size: boneSize))
        
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
