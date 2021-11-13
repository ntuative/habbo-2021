package com.sulake.habbo.communication.messages.parser.gifts
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PhoneCollectionStateParser implements IMessageParser 
    {

        private var _phoneStatusCode:int;
        private var _collectionStatusCode:int;
        private var _millisecondsToAllowProcessReset:int;


        public function get phoneStatusCode():int
        {
            return (_phoneStatusCode);
        }

        public function get collectionStatusCode():int
        {
            return (_collectionStatusCode);
        }

        public function get millisecondsToAllowProcessReset():int
        {
            return (_millisecondsToAllowProcessReset);
        }

        public function flush():Boolean
        {
            _phoneStatusCode = -1;
            _millisecondsToAllowProcessReset = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _phoneStatusCode = _arg_1.readInteger();
            _collectionStatusCode = _arg_1.readInteger();
            _millisecondsToAllowProcessReset = _arg_1.readInteger();
            return (true);
        }


    }
}