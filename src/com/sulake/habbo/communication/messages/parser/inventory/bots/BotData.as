package com.sulake.habbo.communication.messages.parser.inventory.bots
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BotData 
    {

        private var _id:int;
        private var _name:String;
        private var _motto:String;
        private var _gender:String;
        private var _figure:String;

        public function BotData(_arg_1:IMessageDataWrapper)
        {
            _id = _arg_1.readInteger();
            _name = _arg_1.readString();
            _motto = _arg_1.readString();
            _gender = _arg_1.readString();
            _figure = _arg_1.readString();
        }

        public function get id():int
        {
            return (_id);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get motto():String
        {
            return (_motto);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get gender():String
        {
            return (_gender);
        }


    }
}