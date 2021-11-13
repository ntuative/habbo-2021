package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FindFriendsProcessResultMessageParser implements IMessageParser 
    {

        private var _success:Boolean;


        public function get success():Boolean
        {
            return (_success);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _success = _arg_1.readBoolean();
            return (true);
        }


    }
}