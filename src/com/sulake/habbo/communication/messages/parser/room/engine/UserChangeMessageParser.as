package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserChangeMessageParser implements IMessageParser 
    {

        private var _id:int;
        private var _figure:String;
        private var _sex:String;
        private var _customInfo:String;
        private var _achievementScore:int;


        public function get id():int
        {
            return (_id);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get sex():String
        {
            return (_sex);
        }

        public function get customInfo():String
        {
            return (_customInfo);
        }

        public function get achievementScore():int
        {
            return (_achievementScore);
        }

        public function flush():Boolean
        {
            _id = 0;
            _figure = "";
            _sex = "";
            _customInfo = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _id = _arg_1.readInteger();
            _figure = _arg_1.readString();
            _sex = _arg_1.readString();
            _customInfo = _arg_1.readString();
            _achievementScore = _arg_1.readInteger();
            if (_sex)
            {
                _sex = _sex.toUpperCase();
            };
            return (true);
        }


    }
}