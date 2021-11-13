package com.sulake.core.runtime
{
    import com.sulake.core.utils.IFileProxy;
    import flash.utils.Dictionary;
    import flash.events.IEventDispatcher;

        public /*dynamic*/ interface ICore extends IContext, ICoreConfiguration 
    {

        function initialize():void;
        function purge():void;
        function hibernate(_arg_1:int, _arg_2:int=1):void;
        function resume():void;
        function get fileProxy():IFileProxy;
        function writeDictionaryToProxy(_arg_1:String, _arg_2:Dictionary):Boolean;
        function readDictionaryFromProxy(_arg_1:String):Dictionary;
        function writeXMLToProxy(_arg_1:String, _arg_2:XML):Boolean;
        function readXMLFromProxy(_arg_1:String):XML;
        function readStringFromProxy(_arg_1:String):String;
        function writeStringToProxy(_arg_1:String, _arg_2:String):Boolean;
        function readConfigDocument(_arg_1:XML, _arg_2:IEventDispatcher=null):void;
        function getNumberOfFilesPending():uint;
        function getNumberOfFilesLoaded():uint;
        function setProfilerMode(_arg_1:Boolean):void;
        function get arguments():Dictionary;
        function clearArguments():void;

    }
}