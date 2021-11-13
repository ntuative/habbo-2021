package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ExtendedProfileMessageParser implements IMessageParser 
    {

        private var _data:ExtendedProfileData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new ExtendedProfileData(_arg_1);
            return (true);
        }

        public function get data():ExtendedProfileData
        {
            return (_data);
        }


    }
}