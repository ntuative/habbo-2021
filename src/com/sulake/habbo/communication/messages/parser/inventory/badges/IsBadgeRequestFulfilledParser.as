package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IsBadgeRequestFulfilledParser implements IMessageParser 
    {

        private var _requestCode:String;
        private var _fulfilled:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _requestCode = _arg_1.readString();
            _fulfilled = _arg_1.readBoolean();
            return (true);
        }

        public function get requestCode():String
        {
            return (_requestCode);
        }

        public function get fulfilled():Boolean
        {
            return (_fulfilled);
        }


    }
}