package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NotEnoughBalanceMessageParser implements IMessageParser 
    {

        private var _notEnoughCredits:Boolean = false;
        private var _notEnoughActivityPoints:Boolean = false;
        private var _activityPointType:int = 0;


        public function get notEnoughCredits():Boolean
        {
            return (_notEnoughCredits);
        }

        public function get notEnoughActivityPoints():Boolean
        {
            return (_notEnoughActivityPoints);
        }

        public function get activityPointType():int
        {
            return (_activityPointType);
        }

        public function flush():Boolean
        {
            _notEnoughCredits = false;
            _notEnoughActivityPoints = false;
            _activityPointType = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _notEnoughCredits = _arg_1.readBoolean();
            _notEnoughActivityPoints = _arg_1.readBoolean();
            if (_arg_1.bytesAvailable)
            {
                _activityPointType = _arg_1.readInteger();
            };
            return (true);
        }


    }
}