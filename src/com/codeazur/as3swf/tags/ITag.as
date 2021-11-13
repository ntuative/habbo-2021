package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public /*dynamic*/ interface ITag 
    {

        function get type():uint;
        function get name():String;
        function get version():uint;
        function get level():uint;
        function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void;
        function publish(_arg_1:SWFData, _arg_2:uint):void;
        function toString(_arg_1:uint=0):String;

    }
}