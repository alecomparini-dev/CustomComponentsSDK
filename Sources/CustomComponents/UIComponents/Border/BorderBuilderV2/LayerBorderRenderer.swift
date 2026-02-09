//  Created by Alessandro Comparini on 09/02/26.
//


final class LayerBorderRenderer: BorderRenderer {

    func render(context: BorderRenderContext) {

        guard let view = context.view else { return }

        view.layer.cornerRadius = context.cornerRadius
        view.layer.borderWidth = context.borderWidth
        view.layer.borderColor = context.borderColor?.cgColor
        view.layer.maskedCorners = context.maskedCorners
        view.layer.masksToBounds = true
    }
}
