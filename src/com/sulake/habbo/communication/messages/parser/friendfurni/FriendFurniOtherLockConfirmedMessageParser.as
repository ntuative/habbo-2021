package com.sulake.habbo.communication.messages.parser.friendfurni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FriendFurniOtherLockConfirmedMessageParser implements IMessageParser 
    {

        private var _stuffId:int;


        public function get stuffId():int
        {
            return (_stuffId);
        }

        public function flush():Boolean
        {
            _stuffId = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _stuffId = _arg_1.readInteger();
            return (true);
        }


    }
}