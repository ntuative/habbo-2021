package com.sulake.habbo.messenger
{
    import flash.utils.getTimer;

    public class ChatEntry 
    {

        public static const TYPE_OWN_CHAT:int = 1;
        public static const TYPE_OTHER_CHAT:int = 2;
        public static const _SafeStr_2802:int = 3;
        public static const TYPE_INFO:int = 4;
        public static const _SafeStr_2803:int = 5;

        private var _type:int;
        private var _senderId:int;
        private var _message:String;
        private var _SafeStr_2804:int;
        private var _clientReceiveTime:int;
        private var _extraData:String;

        public function ChatEntry(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:String=null)
        {
            _type = _arg_1;
            _senderId = _arg_2;
            _message = _arg_3;
            _SafeStr_2804 = _arg_4;
            _clientReceiveTime = getTimer();
            _extraData = _arg_5;
        }

        public function get type():int
        {
            return (_type);
        }

        public function get senderId():int
        {
            return (_senderId);
        }

        public function get message():String
        {
            return (_message);
        }

        public function get extraData():String
        {
            return (_extraData);
        }

        public function get secondsSinceSent():int
        {
            var _local_1:int = int(((getTimer() - _clientReceiveTime) / 1000));
            return (_SafeStr_2804 + _local_1);
        }

        public function sentTimeStamp():Number
        {
            return (new Date().getTime() - (secondsSinceSent * 1000));
        }

        public function prefixMessageWith(_arg_1:String):void
        {
            _message = ((_arg_1 + "\n") + _message);
        }


    }
}

