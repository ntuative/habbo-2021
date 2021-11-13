package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BadgeReceivedParser implements IMessageParser 
    {

        private var _badgeId:int;
        private var _badgeCode:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _badgeId = _arg_1.readInteger();
            _badgeCode = _arg_1.readString();
            return (true);
        }

        public function get badgeId():int
        {
            return (_badgeId);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }


    }
}