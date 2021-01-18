//
//  GameImage.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-16.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import UIKit

public class GameImage {
    private let UNIT_IMAGE_NUMBER = 8
    private let CLEAR_IMAGE_NUMBER = 1
    private let WALL_IMAGE_NUMBER = 16
    private let MAN_IMAGE_NUMBER = 16
    
    private var scaledImages = [String]()
    
    private static let DEFAULT_STEP = Step(offset: Point.To.LEFT.offset(), push: false, actionId: 0)
    private var currentStep = GameImage.DEFAULT_STEP
    
    public init() {
        scaledImages.append("view_ground")
        scaledImages.append("view_wall")
        scaledImages.append("view_box")
        scaledImages.append("view_floor")
        scaledImages.append("view_dot")
        scaledImages.append("view_box_dot")
        scaledImages.append("view_man")
        scaledImages.append("view_man_dot")
        
        scaledImages.append("view_dot_clear")
        
        scaledImages.append("view_wall_00")
        scaledImages.append("view_wall_01")
        scaledImages.append("view_wall_02")
        scaledImages.append("view_wall_03")
        scaledImages.append("view_wall_04")
        scaledImages.append("view_wall_05")
        scaledImages.append("view_wall_06")
        scaledImages.append("view_wall_07")
        scaledImages.append("view_wall_08")
        scaledImages.append("view_wall_09")
        scaledImages.append("view_wall_10")
        scaledImages.append("view_wall_11")
        scaledImages.append("view_wall_12")
        scaledImages.append("view_wall_13")
        scaledImages.append("view_wall_14")
        scaledImages.append("view_wall_15")
        
        scaledImages.append("view_man_left")
        scaledImages.append("view_man_right")
        scaledImages.append("view_man_up")
        scaledImages.append("view_man_down")
        scaledImages.append("view_man_push_left")
        scaledImages.append("view_man_push_right")
        scaledImages.append("view_man_push_up")
        scaledImages.append("view_man_push_down")
        scaledImages.append("view_man_clear_left")
        scaledImages.append("view_man_clear_right")
        scaledImages.append("view_man_clear_up")
        scaledImages.append("view_man_clear_down")
        scaledImages.append("view_man_clear_push_left")
        scaledImages.append("view_man_clear_push_right")
        scaledImages.append("view_man_clear_push_up")
        scaledImages.append("view_man_clear_push_down")
    }
    
    public func setCurrentStep (step: Step?) {
        self.currentStep = step ?? GameImage.DEFAULT_STEP
    }
    
    public func getCurrentStep() -> Step {
        return self.currentStep
    }
    
    private func isFloorOn() -> Bool {
        return GameSetting.instance().isFloorOn()
    }
    
    public func getUnitImage(units: [[Unit]], x: Int, y: Int) -> String {
        if (units[x][y].isWall()) {
            var index:Int = 0
            if (y > 0) { // left
                index += units[x][y - 1].isWall() ? 1 : 0
            }
            if (y < GameStage.STAGE_HEIGHT - 1) { // right
                index += units[x][y + 1].isWall() ? 2 : 0
            }
            if (x > 0) { // up
                index += units[x - 1][y].isWall() ? 4 : 0
            }
            if (x < GameStage.STAGE_WIDTH - 1) { // down
                index += units[x + 1][y].isWall() ? 8 : 0
            }
            index = GameOption.instance().isPortrait() ? index : index % 4 * 4 + index / 4
            return scaledImages[UNIT_IMAGE_NUMBER + CLEAR_IMAGE_NUMBER + index]
        } else if (units[x][y].isMan()) {
            var index:Int = 0
            let offset:Point = currentStep.getOffset()
            index += offset.equals(point: Point.To.UP.offset()) ? 0 : 0
            index += offset.equals(point: Point.To.DOWN.offset()) ? 1 : 0
            index += offset.equals(point: Point.To.LEFT.offset()) ? 2 : 0
            index += offset.equals(point: Point.To.RIGHT.offset()) ? 3 : 0
            index = GameOption.instance().isPortrait() ? index : (index + 2) % 4
            index += currentStep.isPush() ? 4 : 0
            index += !isFloorOn() ? 8 : 0
            return scaledImages[UNIT_IMAGE_NUMBER + CLEAR_IMAGE_NUMBER + WALL_IMAGE_NUMBER + index]
        } else if (units[x][y].isBox()) {
            return scaledImages[units[x][y].getSymbol().getIndex()]
        } else if (units[x][y].isDot()) {
            return isFloorOn() ? scaledImages[units[x][y].getSymbol().getIndex()] : scaledImages[UNIT_IMAGE_NUMBER]
        } else if (units[x][y].isEmpty()) {
            return isFloorOn() ? scaledImages[units[x][y].getSymbol().getIndex()] : scaledImages[0]
        } else if (units[x][y].isGround()) {
            return scaledImages[0]
        }
        return scaledImages[units[x][y].getSymbol().getIndex()]
    }
}
