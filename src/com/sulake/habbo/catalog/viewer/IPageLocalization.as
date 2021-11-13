package com.sulake.habbo.catalog.viewer
{
    public /*dynamic*/ interface IPageLocalization 
    {

        function get imageCount():int;
        function get textCount():int;
        function getTextElementName(_arg_1:int, _arg_2:String):String;
        function getImageElementName(_arg_1:int, _arg_2:String):String;
        function getTextElementContent(_arg_1:int):String;
        function getImageElementContent(_arg_1:int):String;
        function dispose():void;
        function hasLinks(_arg_1:String):Boolean;
        function getLinks(_arg_1:String):Array;
        function getColorUintFromText(_arg_1:int):uint;

    }
}