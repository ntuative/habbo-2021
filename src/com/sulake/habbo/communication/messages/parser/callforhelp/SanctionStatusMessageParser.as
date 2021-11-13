package com.sulake.habbo.communication.messages.parser.callforhelp
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SanctionStatusMessageParser implements IMessageParser 
    {

        private var _isSanctionNew:Boolean;
        private var _isSanctionActive:Boolean;
        private var _sanctionName:String;
        private var _sanctionLengthHours:int;
        private var _sanctionReason:String;
        private var _sanctionCreationTime:String;
        private var _probationHoursLeft:int;
        private var _nextSanctionName:String;
        private var _nextSanctionLengthHours:int;
        private var _hasCustomMute:Boolean;
        private var _tradeLockExpiryTime:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isSanctionNew = _arg_1.readBoolean();
            _isSanctionActive = _arg_1.readBoolean();
            _sanctionName = _arg_1.readString();
            _sanctionLengthHours = _arg_1.readInteger();
            _arg_1.readInteger();
            _sanctionReason = _arg_1.readString();
            _sanctionCreationTime = _arg_1.readString();
            _probationHoursLeft = _arg_1.readInteger();
            _nextSanctionName = _arg_1.readString();
            _nextSanctionLengthHours = _arg_1.readInteger();
            _arg_1.readInteger();
            _hasCustomMute = _arg_1.readBoolean();
            if (_arg_1.bytesAvailable)
            {
                _tradeLockExpiryTime = _arg_1.readString();
            };
            return (true);
        }

        public function get isSanctionNew():Boolean
        {
            return (_isSanctionNew);
        }

        public function get isSanctionActive():Boolean
        {
            return (_isSanctionActive);
        }

        public function get sanctionName():String
        {
            return (_sanctionName);
        }

        public function get sanctionLengthHours():int
        {
            return (_sanctionLengthHours);
        }

        public function get sanctionReason():String
        {
            return (_sanctionReason);
        }

        public function get sanctionCreationTime():String
        {
            return (_sanctionCreationTime);
        }

        public function get probationHoursLeft():int
        {
            return (_probationHoursLeft);
        }

        public function get nextSanctionName():String
        {
            return (_nextSanctionName);
        }

        public function get nextSanctionLengthHours():int
        {
            return (_nextSanctionLengthHours);
        }

        public function get hasCustomMute():Boolean
        {
            return (_hasCustomMute);
        }

        public function get tradeLockExpiryTime():String
        {
            return (_tradeLockExpiryTime);
        }


    }
}