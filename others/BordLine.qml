import QtQuick
import QtQuick.Shapes

Shape{
    ShapePath{
        strokeColor: "#33B5E5"
        strokeWidth: 2
        startX: 0;startY: mainRect.height+statusBar.height
        PathLine{x:root.width;y:mainRect.height+statusBar.height}
    }
    ShapePath{
        strokeColor: "#33B5E5"
        strokeWidth: 2
        startX: subRectLeft.width ;startY: mainRect.height+statusBar.height
        PathLine{x:subRectLeft.width;y:root.height}
    }
}
