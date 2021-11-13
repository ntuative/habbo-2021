package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ModeratorInitMessageParser implements IMessageParser 
    {

        private var _data:ModeratorInitData;


        public function flush():Boolean
        {
            if (_data != null)
            {
                _data.dispose();
                _data = null;
            };
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new ModeratorInitData(_arg_1);
            return (true);
        }

        public function get data():ModeratorInitData
        {
            return (_data);
        }


    }
}