package com.sulake.core.assets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.LibraryLoader;
    import flash.net.URLRequest;

    public /*dynamic*/ interface IAssetLibrary extends IDisposable 
    {

        function get url():String;
        function get name():String;
        function get isReady():Boolean;
        function get numAssets():uint;
        function get manifest():XML;
        function get nameArray():Array;
        function loadFromFile(_arg_1:LibraryLoader, _arg_2:Boolean=true):void;
        function loadFromResource(_arg_1:XML, _arg_2:Class):Boolean;
        function unload():void;
        function loadAssetFromFile(_arg_1:String, _arg_2:URLRequest, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:int=-1):AssetLoaderStruct;
        function getAssetByName(_arg_1:String):IAsset;
        function getAssetByContent(_arg_1:Object):IAsset;
        function getAssetByIndex(_arg_1:uint):IAsset;
        function getAssetIndex(_arg_1:IAsset):int;
        function hasAsset(_arg_1:String):Boolean;
        function setAsset(_arg_1:String, _arg_2:IAsset, _arg_3:Boolean=true):Boolean;
        function createAsset(_arg_1:String, _arg_2:AssetTypeDeclaration):IAsset;
        function removeAsset(_arg_1:IAsset):IAsset;
        function registerAssetTypeDeclaration(_arg_1:AssetTypeDeclaration, _arg_2:Boolean=true):Boolean;
        function getAssetTypeDeclarationByMimeType(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration;
        function getAssetTypeDeclarationByClass(_arg_1:Class, _arg_2:Boolean=true):AssetTypeDeclaration;
        function getAssetTypeDeclarationByFileName(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration;

    }
}