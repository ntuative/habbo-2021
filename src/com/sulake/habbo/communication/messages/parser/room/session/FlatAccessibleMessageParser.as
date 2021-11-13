package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FlatAccessibleMessageParser implements IMessageParser 
    {

        private var _flatId:int = 0;
        private var _userName:String = null;


        public function get userName():String
        {
            return (_userName);
        }

        public function get flatId():int
        {
            return (_flatId);
        }

        public function flush():Boolean
        {
            _userName = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _flatId = _arg_1.readInteger();
            _userName = _arg_1.readString();
            return (true);
        }


    }
}