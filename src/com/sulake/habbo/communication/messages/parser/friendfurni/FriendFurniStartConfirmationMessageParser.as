package com.sulake.habbo.communication.messages.parser.friendfurni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FriendFurniStartConfirmationMessageParser implements IMessageParser 
    {

        private var _stuffId:int;
        private var _isOwner:Boolean;


        public function get stuffId():int
        {
            return (_stuffId);
        }

        public function get isOwner():Boolean
        {
            return (_isOwner);
        }

        public function flush():Boolean
        {
            _stuffId = -1;
            _isOwner = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _stuffId = _arg_1.readInteger();
            _isOwner = _arg_1.readBoolean();
            return (true);
        }


    }
}