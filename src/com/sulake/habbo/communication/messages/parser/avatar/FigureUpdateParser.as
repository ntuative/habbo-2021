package com.sulake.habbo.communication.messages.parser.avatar
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FigureUpdateParser implements IMessageParser 
    {

        private var _figure:String;
        private var _gender:String;


        public function get figure():String
        {
            return (_figure);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function flush():Boolean
        {
            _figure = "";
            _gender = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _figure = _arg_1.readString();
            _gender = _arg_1.readString();
            if (_gender)
            {
                _gender = _gender.toUpperCase();
            };
            return (true);
        }


    }
}