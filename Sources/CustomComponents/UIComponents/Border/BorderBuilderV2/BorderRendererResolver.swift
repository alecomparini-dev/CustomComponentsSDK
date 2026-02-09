//  Created by Alessandro Comparini on 09/02/26.
//


struct BorderRendererResolver {

    static func resolve(context: BorderRenderContext) -> BorderRenderer {

        if context.modernButton != nil && context.hasIndividualCorners {
            return ShapeLayerBorderRenderer()
        }

        if context.modernButton != nil {
            return UIButtonConfigurationBorderRenderer()
        }

        return LayerBorderRenderer()
    }
}
