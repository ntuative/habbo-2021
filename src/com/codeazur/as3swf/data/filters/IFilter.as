package com.codeazur.as3swf.data.filters
{
    import flash.filters.BitmapFilter;
    import com.codeazur.as3swf.SWFData;

    public /*dynamic*/ interface IFilter 
    {

        function get id():uint;
        function get filter():BitmapFilter;
        function parse(_arg_1:SWFData):void;
        function publish(_arg_1:SWFData):void;
        function clone():IFilter;
        function toString(_arg_1:uint=0):String;

    }
}