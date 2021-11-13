package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BadgePartData 
    {

        private var _id:int;
        private var _fileName:String;
        private var _maskFileName:String;

        public function BadgePartData(_arg_1:IMessageDataWrapper=null)
        {
            _id = _arg_1.readInteger();
            _fileName = _arg_1.readString();
            _maskFileName = _arg_1.readString();
        }

        public function get id():int
        {
            return (_id);
        }

        public function get fileName():String
        {
            return (_fileName);
        }

        public function get maskFileName():String
        {
            return (_maskFileName);
        }


    }
}