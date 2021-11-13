package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.avatar.structure.IFigureSetData;
    import __AS3__.vec.Vector;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.avatar.animation.IAnimationManager;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;

    public /*dynamic*/ interface IAvatarRenderManager extends IUnknown 
    {

        function createAvatarImage(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:IAvatarImageListener=null, _arg_5:IAvatarEffectListener=null):IAvatarImage;
        function get assets():IAssetLibrary;
        function getFigureData():IFigureSetData;
        function getFigureStringWithFigureIds(_arg_1:String, _arg_2:String, _arg_3:Vector.<int>):String;
        function isValidFigureSetForGender(_arg_1:int, _arg_2:String):Boolean;
        function getMandatoryAvatarPartSetIds(_arg_1:String, _arg_2:int):Array;
        function getAssetByName(_arg_1:String):IAsset;
        function get mode():String;
        function set mode(_arg_1:String):void;
        function injectFigureData(_arg_1:XML):void;
        function createFigureContainer(_arg_1:String):IAvatarFigureContainer;
        function isFigureReady(_arg_1:IAvatarFigureContainer):Boolean;
        function downloadFigure(_arg_1:IAvatarFigureContainer, _arg_2:IAvatarImageListener):void;
        function getAnimationManager():IAnimationManager;
        function get events():IEventDispatcher;
        function resetAssetManager():void;
        function resolveClubLevel(_arg_1:IAvatarFigureContainer, _arg_2:String, _arg_3:Array=null):int;
        function getItemIds():Array;
        function get effectMap():Dictionary;

    }
}