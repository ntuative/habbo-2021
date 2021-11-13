package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserRightsMessageParser implements IMessageParser 
    {

        private var _clubLevel:int;
        private var _securityLevel:int;
        private var _isAmbassador:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _clubLevel = _arg_1.readInteger();
            _securityLevel = _arg_1.readInteger();
            _isAmbassador = _arg_1.readBoolean();
            return (true);
        }

        public function get clubLevel():int
        {
            return (_clubLevel);
        }

        public function get securityLevel():int
        {
            return (_securityLevel);
        }

        public function get isAmbassador():Boolean
        {
            return (_isAmbassador);
        }


    }
}