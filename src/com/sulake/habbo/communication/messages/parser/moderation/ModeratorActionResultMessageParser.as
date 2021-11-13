package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ModeratorActionResultMessageParser implements IMessageParser 
    {

        private var _userId:int;
        private var _success:Boolean;


        public function get userId():int
        {
            return (_userId);
        }

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
            _userId = _arg_1.readInteger();
            _success = _arg_1.readBoolean();
            return (true);
        }


    }
}