package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ScrSendUserInfoMessageParser implements IMessageParser 
    {

        public static const _SafeStr_2117:int = 1;
        public static const _SafeStr_2118:int = 2;
        public static const _SafeStr_2119:int = 3;
        public static const _SafeStr_2120:int = 4;

        private var _productName:String;
        private var _daysToPeriodEnd:int;
        private var _memberPeriods:int;
        private var _periodsSubscribedAhead:int;
        private var _responseType:int;
        private var _hasEverBeenMember:Boolean;
        private var _isVIP:Boolean;
        private var _pastClubDays:int;
        private var _pastVipDays:int;
        private var _minutesUntilExpiration:int;
        private var _minutesSinceLastModified:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _productName = _arg_1.readString();
            _daysToPeriodEnd = _arg_1.readInteger();
            _memberPeriods = _arg_1.readInteger();
            _periodsSubscribedAhead = _arg_1.readInteger();
            _responseType = _arg_1.readInteger();
            _hasEverBeenMember = _arg_1.readBoolean();
            _isVIP = _arg_1.readBoolean();
            _pastClubDays = _arg_1.readInteger();
            _pastVipDays = _arg_1.readInteger();
            _minutesUntilExpiration = _arg_1.readInteger();
            if (_arg_1.bytesAvailable)
            {
                _minutesSinceLastModified = _arg_1.readInteger();
            };
            return (true);
        }

        public function get productName():String
        {
            return (_productName);
        }

        public function get daysToPeriodEnd():int
        {
            return (_daysToPeriodEnd);
        }

        public function get memberPeriods():int
        {
            return (_memberPeriods);
        }

        public function get periodsSubscribedAhead():int
        {
            return (_periodsSubscribedAhead);
        }

        public function get responseType():int
        {
            return (_responseType);
        }

        public function get hasEverBeenMember():Boolean
        {
            return (_hasEverBeenMember);
        }

        public function get isVIP():Boolean
        {
            return (_isVIP);
        }

        public function get pastClubDays():int
        {
            return (_pastClubDays);
        }

        public function get pastVipDays():int
        {
            return (_pastVipDays);
        }

        public function get minutesUntilExpiration():int
        {
            return (_minutesUntilExpiration);
        }

        public function get minutesSinceLastModified():int
        {
            return (_minutesSinceLastModified);
        }


    }
}

