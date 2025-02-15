
// Created with Qt Design Studio (version 4.7.0), Sat Feb 15 06:28:12 2025
// Do not manually edit this file, it will be overwritten if effect is modified in Qt Design Studio.

import QtQuick

Item {
    id: rootItem

    // Use visible property to show and hide the effect.
    visible: true

    // This is an internal property used by tooling to identify effect items. Do not modify.
    property bool _isEffectItem

    // This is an internal property used to manage the effect. Do not modify.
    property Item _oldParent: null

    // This is the main source for the effect. Set internally to the current parent item. Do not modify.
    property Item source: null

    // This property specifies how much of extra space is reserved for the effect outside the parent geometry.
    // It should be sufficient for most use cases but if the application uses extreme values it may be necessary to
    // increase this value.
    property int extraMargin: 80

    onExtraMarginChanged: setupSourceRect()

    function setupSourceRect() {
        if (source) {
            var w = source.width + extraMargin * 2
            var h = source.height + extraMargin * 2
            source.layer.sourceRect = Qt.rect(-extraMargin, -extraMargin, w, h)
        }
    }

    function connectSource(enable) {
        if (source) {
            if (enable) {
                source.widthChanged.connect(setupSourceRect)
                source.heightChanged.connect(setupSourceRect)
            } else {
                source.widthChanged.disconnect(setupSourceRect)
                source.heightChanged.disconnect(setupSourceRect)
            }
        }
    }

    function setupParentLayer()
    {
        if (_oldParent && _oldParent !== parent) {
            _oldParent.layer.enabled = false
            _oldParent.layer.effect = null
            
            connectSource(false)
            source = null
            _oldParent.update()
            _oldParent = null
        }
        if (parent) {
            _oldParent = parent
            if (visible) {
                parent.layer.enabled = true
                parent.layer.effect = effectComponent
                
                connectSource(false)
            source = parent
            connectSource(true)
            setupSourceRect()
            } else {
                parent.layer.enabled = false
                parent.layer.effect = null
                
                connectSource(false)
            source = null
            }
            parent.update()
        }

    }

    onParentChanged: setupParentLayer()

    onVisibleChanged: setupParentLayer()

    // This property defines a multiplier for extending the blur radius.
    //
    // By default, the property is set to 0.0 (not multiplied). Incresing the multiplier extends the blur radius, but decreases the blur quality. This is more performant option for a bigger blur radius than Max Blur Level as it doesn't increase the amount of texture lookups.
    //
    // Note: This affects to both blur and shadow effects.
    property real blurMultiplier: 0
    // Sets the amount of blur (radius) applied to the shadow.
    //
    // The value ranges from 0.0 (no blur) to 1.0 (full blur).
    //
    // The amount of blur is also affected by the Blur Helper Multiplier property.
    property real dropShadowBlurAmount: 1
    // Sets the color of the shadow.
    property color dropShadowColor: "#000000"
    // Sets the size of the shadow.
    property real dropShadowScale: 1
    // Sets the horizontal position of the shadow.
    property real dropShadowHorizontalOffset: 0
    // Sets the vertical position of the shadow.
    property real dropShadowVerticalOffset: 0

    Component {
        id: effectComponent
        ShaderEffect {
            property Item source: null
            readonly property Item iSource: rootItem.source
            readonly property vector3d iResolution: Qt.vector3d(width, height, 1.0)
            readonly property Item iSourceBlur1: blurHelper.blurSrc1
            readonly property Item iSourceBlur2: blurHelper.blurSrc2
            readonly property Item iSourceBlur3: blurHelper.blurSrc3
            readonly property Item iSourceBlur4: blurHelper.blurSrc4
            readonly property Item iSourceBlur5: blurHelper.blurSrc5
            readonly property real blurMultiplier: rootItem.blurMultiplier
            readonly property real dropShadowBlurAmount: rootItem.dropShadowBlurAmount
            readonly property color dropShadowColor: rootItem.dropShadowColor
            readonly property real dropShadowScale: rootItem.dropShadowScale
            readonly property real dropShadowHorizontalOffset: rootItem.dropShadowHorizontalOffset
            readonly property real dropShadowVerticalOffset: rootItem.dropShadowVerticalOffset

            vertexShader: 'dropshadow.vert.qsb'
            fragmentShader: 'dropshadow.frag.qsb'
            anchors.fill: rootItem.source
            anchors.margins: -rootItem.extraMargin
            BlurHelper {
                id: blurHelper
                source: rootItem.source
                property int blurMax: 32
                property real blurMultiplier: rootItem.blurMultiplier
            }
        }
    }
}
