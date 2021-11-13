package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;

    public /*dynamic*/ interface IAvatarImage extends IDisposable 
    {

        function getCroppedImage(_arg_1:String, _arg_2:Number=1):BitmapData;
        function getImage(_arg_1:String, _arg_2:Boolean, _arg_3:Number=1):BitmapData;
        function getServerRenderData():Array;
        function setDirection(_arg_1:String, _arg_2:int):void;
        function setDirectionAngle(_arg_1:String, _arg_2:int):void;
        function updateAnimationByFrames(_arg_1:int=1):void;
        function getScale():String;
        function getSprites():Vector.<ISpriteDataContainer>;
        function getLayerData(_arg_1:ISpriteDataContainer):IAnimationLayerData;
        function getAsset(_arg_1:String):BitmapDataAsset;
        function getDirection():int;
        function getFigure():IAvatarFigureContainer;
        function getPartColor(_arg_1:String):IPartColor;
        function isAnimating():Boolean;
        function getCanvasOffsets():Array;
        function initActionAppends():void;
        function endActionAppends():void;
        function appendAction(_arg_1:String, ... _args):Boolean;
        function get avatarSpriteData():IAvatarDataContainer;
        function isPlaceholder():Boolean;
        function forceActionUpdate():void;
        function get animationHasResetOnToggle():Boolean;
        function resetAnimationFrameCounter():void;
        function get mainAction():String;

    }
}