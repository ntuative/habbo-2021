package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.ScrKickbackData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ScrSendKickbackInfoMessageParser implements IMessageParser 
    {

        private var _data:ScrKickbackData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new ScrKickbackData(_arg_1);
            return (true);
        }

        public function get data():ScrKickbackData
        {
            return (_data);
        }


    }
}