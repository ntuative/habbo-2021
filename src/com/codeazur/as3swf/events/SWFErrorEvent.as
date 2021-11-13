package com.codeazur.as3swf.events
{
    import flash.events.Event;

    public class SWFErrorEvent extends Event 
    {

        public static const ERROR:String = "error";
        public static const REASON_EOF:String = "eof";

        public var reason:String;

        public function SWFErrorEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this.reason = _arg_2;
        }

        override public function clone():Event
        {
            return (new SWFErrorEvent(type, reason, bubbles, cancelable));
        }

        override public function toString():String
        {
            return ("[SWFParseErrorEvent] reason: " + reason);
        }


    }
}