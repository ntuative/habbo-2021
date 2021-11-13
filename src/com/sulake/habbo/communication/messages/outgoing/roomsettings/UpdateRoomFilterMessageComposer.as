package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class UpdateRoomFilterMessageComposer implements IMessageComposer, IDisposable 
    {

        public static var _SafeStr_626:Boolean = true;
        public static var _SafeStr_627:Boolean = false;

        private var _SafeStr_875:Array = [];

        public function UpdateRoomFilterMessageComposer(_arg_1:int, _arg_2:Boolean, _arg_3:String)
        {
            _SafeStr_875.push(_arg_1);
            _SafeStr_875.push(_arg_2);
            _SafeStr_875.push(_arg_3);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }

        public function dispose():void
        {
            _SafeStr_875 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}

