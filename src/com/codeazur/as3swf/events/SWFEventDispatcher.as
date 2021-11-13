package com.codeazur.as3swf.events
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;

    public class SWFEventDispatcher implements IEventDispatcher 
    {

        protected var _SafeStr_717:EventDispatcher;

        public function SWFEventDispatcher()
        {
            _SafeStr_717 = new EventDispatcher(this);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _SafeStr_717.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _SafeStr_717.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_SafeStr_717.dispatchEvent(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_SafeStr_717.hasEventListener(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_SafeStr_717.willTrigger(_arg_1));
        }


    }
}

