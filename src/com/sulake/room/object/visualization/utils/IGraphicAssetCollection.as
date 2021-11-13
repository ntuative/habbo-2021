package com.sulake.room.object.visualization.utils
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;

    public /*dynamic*/ interface IGraphicAssetCollection 
    {

        function dispose():void;
        function set assetLibrary(_arg_1:IAssetLibrary):void;
        function addReference():void;
        function removeReference():void;
        function getReferenceCount():int;
        function getLastReferenceTimeStamp():int;
        function define(_arg_1:XML):Boolean;
        function getAsset(_arg_1:String):IGraphicAsset;
        function getAssetWithPalette(_arg_1:String, _arg_2:String):IGraphicAsset;
        function getPaletteNames():Array;
        function getPaletteColors(_arg_1:String):Array;
        function getPaletteXML(_arg_1:String):XML;
        function addAsset(_arg_1:String, _arg_2:BitmapData, _arg_3:Boolean, _arg_4:int=0, _arg_5:int=0, _arg_6:Boolean=false, _arg_7:Boolean=false):Boolean;
        function disposeAsset(_arg_1:String):void;

    }
}