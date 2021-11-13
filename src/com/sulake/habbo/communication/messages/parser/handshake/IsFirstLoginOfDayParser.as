package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IsFirstLoginOfDayParser implements IMessageParser 
    {

        private var _isFirstLoginOfDay:Boolean;


        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._isFirstLoginOfDay = _arg_1.readBoolean();
            return (true);
        }

        public function get isFirstLoginOfDay():Boolean
        {
            return (_isFirstLoginOfDay);
        }


    }
}