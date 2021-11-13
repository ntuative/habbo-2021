package com.codeazur.as3swf.data.actions
{
    import com.codeazur.as3swf.SWFData;

    public /*dynamic*/ interface IAction 
    {

        function get code():uint;
        function get length():uint;
        function parse(_arg_1:SWFData):void;
        function publish(_arg_1:SWFData):void;
        function clone():IAction;
        function toString(_arg_1:uint=0):String;

    }
}