//
//  UIButtonConfigurationBorderRenderer.swift
//  CustomComponentsSDK
//
//  Created by Alessandro Comparini on 09/02/26.
//


final class UIButtonConfigurationBorderRenderer: BorderRenderer {

    func render(context: BorderRenderContext) {

        guard let button = context.modernButton else { return }

        var config = button.configuration!
        var background = config.background ?? .clear()

        background.cornerRadius = context.cornerRadius
        background.strokeWidth = context.borderWidth
        background.strokeColor = context.borderColor
        
        

        config.background = background
        button.configuration = config
    }
}
