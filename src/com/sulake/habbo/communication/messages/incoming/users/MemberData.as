package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MemberData 
    {

        private static const _SafeStr_1858:int = 0;
        private static const _SafeStr_1859:int = 1;
        private static const _SafeStr_1860:int = 2;
        private static const _SafeStr_1861:int = 3;
        private static const _SafeStr_1862:int = 4;

        private var _SafeStr_741:int;
        private var _userId:int;
        private var _userName:String;
        private var _figure:String;
        private var _memberSince:String;

        public function MemberData(_arg_1:IMessageDataWrapper)
        {
            _SafeStr_741 = _arg_1.readInteger();
            _userId = _arg_1.readInteger();
            _userName = _arg_1.readString();
            _figure = _arg_1.readString();
            _memberSince = _arg_1.readString();
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get admin():Boolean
        {
            return (_SafeStr_741 == 1);
        }

        public function get owner():Boolean
        {
            return (_SafeStr_741 == 0);
        }

        public function get member():Boolean
        {
            return (!(_SafeStr_741 == 3));
        }

        public function get blocked():Boolean
        {
            return (_SafeStr_741 == 4);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get memberSince():String
        {
            return (_memberSince);
        }


    }
}

