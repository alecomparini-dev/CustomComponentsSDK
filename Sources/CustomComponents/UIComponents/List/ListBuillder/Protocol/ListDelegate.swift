//  Created by Alessandro Comparini on 17/07/25.
//

import UIKit

@MainActor
public protocol ListDelegate: AnyObject {
    //REQUIRED
    func numberOfSections(_ list: ListBuilder) -> Int
    func numberOfRows(_ list: ListBuilder, section: Int) -> Int
    func sectionViewCallback(_ list: ListBuilder, section: Int) -> UIView?
    func rowViewCallBack(_ list: ListBuilder, section: Int, row: Int) -> Any
    
    //OPTIONAL
    func shouldSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int) -> Bool
    func didSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int)
    func didDeselectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int)
    func scrollViewDidScroll(_ list: ListBuilder, _ scrollView: UIScrollView)
    func scrollViewWillBeginDragging(_ list: ListBuilder, _ scrollView: UIScrollView)
}
