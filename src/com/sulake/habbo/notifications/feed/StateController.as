package com.sulake.habbo.notifications.feed
{
    public class StateController 
    {

        private var _SafeStr_1357:Boolean;
        private var _SafeStr_3029:Boolean;
        private var _SafeStr_2727:int = 0;
        private var _SafeStr_3030:int = 1;


        private function isActive():Boolean
        {
            return ((_SafeStr_1357) && (!(_SafeStr_3029)));
        }

        public function setEnabled(_arg_1:Boolean):int
        {
            _SafeStr_1357 = _arg_1;
            if (!isActive())
            {
                return (requestState(0));
            };
            return (setVisible());
        }

        public function setGameMode(_arg_1:Boolean):int
        {
            _SafeStr_3029 = _arg_1;
            if (!isActive())
            {
                return (requestState(0));
            };
            return (setVisible());
        }

        public function currentState():int
        {
            return (_SafeStr_2727);
        }

        public function requestState(_arg_1:int):int
        {
            if (!isActive())
            {
                _SafeStr_3030 = _arg_1;
                return (_SafeStr_2727);
            };
            _SafeStr_2727 = _arg_1;
            _SafeStr_3030 = _arg_1;
            return (_SafeStr_2727);
        }

        private function setVisible():int
        {
            var _local_1:int = _SafeStr_3030;
            if (_local_1 == 0)
            {
                _local_1 = 1;
            };
            _SafeStr_2727 = _local_1;
            _SafeStr_3030 = _local_1;
            return (_local_1);
        }


    }
}

