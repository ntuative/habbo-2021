package com.codeazur.as3swf.events
{
    import flash.events.Event;

    public class SWFProgressEvent extends Event 
    {

        public static const PROGRESS:String = "progress";
        public static const COMPLETE:String = "complete";

        protected var _SafeStr_718:uint;
        protected var total:uint;

        public function SWFProgressEvent(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            this._SafeStr_718 = _arg_2;
            this.total = _arg_3;
        }

        public function get progress():Number
        {
            return (_SafeStr_718 / total);
        }

        public function get progressPercent():Number
        {
            return (Math.round((progress * 100)));
        }

        override public function clone():Event
        {
            return (new SWFProgressEvent(type, _SafeStr_718, total, bubbles, cancelable));
        }

        override public function toString():String
        {
            return (((((("[SWFProgressEvent] processed: " + _SafeStr_718) + ", total: ") + total) + " (") + progressPercent) + "%)");
        }


    }
}

