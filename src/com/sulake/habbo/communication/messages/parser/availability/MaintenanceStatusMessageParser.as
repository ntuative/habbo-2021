package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MaintenanceStatusMessageParser implements IMessageParser 
    {

        private var _isInMaintenance:Boolean;
        private var _minutesUntilMaintenance:int;
        private var _duration:int = 15;


        public function get isInMaintenance():Boolean
        {
            return (_isInMaintenance);
        }

        public function get minutesUntilMaintenance():int
        {
            return (_minutesUntilMaintenance);
        }

        public function get duration():int
        {
            return (_duration);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isInMaintenance = _arg_1.readBoolean();
            _minutesUntilMaintenance = _arg_1.readInteger();
            if (_arg_1.bytesAvailable)
            {
                _duration = _arg_1.readInteger();
            };
            return (true);
        }


    }
}