package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomInviteMessageParser implements IMessageParser 
    {

        private var _SafeStr_1721:int;
        private var _SafeStr_1982:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._SafeStr_1721 = _arg_1.readInteger();
            this._SafeStr_1982 = _arg_1.readString();
            return (true);
        }

        public function get senderId():int
        {
            return (this._SafeStr_1721);
        }

        public function get messageText():String
        {
            return (this._SafeStr_1982);
        }


    }
}

