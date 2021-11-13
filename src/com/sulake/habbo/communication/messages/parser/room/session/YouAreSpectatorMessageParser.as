package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class YouAreSpectatorMessageParser implements IMessageParser 
    {

        private var _flatId:int = 0;


        public function get flatId():int
        {
            return (_flatId);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _flatId = _arg_1.readInteger();
            return (true);
        }


    }
}