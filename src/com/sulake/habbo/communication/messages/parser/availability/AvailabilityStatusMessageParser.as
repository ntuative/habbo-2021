package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AvailabilityStatusMessageParser implements IMessageParser 
    {

        private var _isOpen:Boolean;
        private var _onShutDown:Boolean;
        private var _isAuthenticHabbo:Boolean;


        public function get isOpen():Boolean
        {
            return (_isOpen);
        }

        public function get onShutDown():Boolean
        {
            return (_onShutDown);
        }

        public function get isAuthenticHabbo():Boolean
        {
            return (_isAuthenticHabbo);
        }

        public function flush():Boolean
        {
            _isOpen = false;
            _onShutDown = false;
            _isAuthenticHabbo = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isOpen = _arg_1.readBoolean();
            _onShutDown = _arg_1.readBoolean();
            if (_arg_1.bytesAvailable)
            {
                _isAuthenticHabbo = _arg_1.readBoolean();
            };
            return (true);
        }


    }
}