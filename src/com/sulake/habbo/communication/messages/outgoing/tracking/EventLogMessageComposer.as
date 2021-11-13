package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class EventLogMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_826:String;
        private var _SafeStr_741:String;
        private var _action:String;
        private var _extraString:String;
        private var _SafeStr_1943:int;

        public function EventLogMessageComposer(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="", _arg_5:int=0)
        {
            _SafeStr_826 = ((_arg_1) ? _arg_1 : "");
            _SafeStr_741 = ((_arg_2) ? _arg_2 : "");
            _action = ((_arg_3) ? _arg_3 : "");
            _extraString = ((_arg_4) ? _arg_4 : "");
            _SafeStr_1943 = ((_arg_5) ? _arg_5 : 0);
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_826, _SafeStr_741, _action, _extraString, _SafeStr_1943]);
        }


    }
}

