package com.sulake.habbo.navigator.cache
{
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultContainer;

    public class NavigatorCacheEntry 
    {

        private var _key:String;
        private var _payload:SearchResultContainer;
        private var _SafeStr_2892:Number;
        private var _SafeStr_2893:Number;

        public function NavigatorCacheEntry(_arg_1:String, _arg_2:SearchResultContainer, _arg_3:Number, _arg_4:Number)
        {
            _key = _arg_1;
            _payload = _arg_2;
            _SafeStr_2892 = _arg_3;
            _SafeStr_2893 = _arg_4;
        }

        public function hasExpired(_arg_1:Number):Boolean
        {
            return (_arg_1 >= _SafeStr_2893);
        }

        public function get key():String
        {
            return (_key);
        }

        public function get payload():SearchResultContainer
        {
            return (_payload);
        }


    }
}

