package com.sulake.core.assets
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface IAsset extends IDisposable 
    {

        function get url():String;
        function get content():Object;
        function get declaration():AssetTypeDeclaration;
        function setUnknownContent(_arg_1:Object):void;
        function setFromOtherAsset(_arg_1:IAsset):void;
        function setParamsDesc(_arg_1:XMLList):void;

    }
}