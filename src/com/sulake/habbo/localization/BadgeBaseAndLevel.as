package com.sulake.habbo.localization
{
    public class BadgeBaseAndLevel
    {

        private var _base:String = "";
        private var _level:int = 1;

        public function BadgeBaseAndLevel(_arg_1:String)
        {
            var _local_2:int = (_arg_1.length - 1);
            while (((_local_2 > 0) && (isNumber(_arg_1.charAt(_local_2)))))
            {
                _local_2--;
            };
            _base = _arg_1.substring(0, (_local_2 + 1));
            var _local_3:String = _arg_1.substring((_local_2 + 1), _arg_1.length);
            if (((!(_local_3 == null)) && (!(_local_3 == ""))))
            {
                _level = int(_local_3);
            };
        }

        private function isNumber(_arg_1:String):Boolean
        {
            var _local_2:int = _arg_1.charCodeAt(0);
            return ((_local_2 >= 48) && (_local_2 <= 57));
        }

        public function get base():String
        {
            return (_base);
        }

        public function get level():int
        {
            return (_level);
        }

        public function set level(_arg_1:int):void
        {
            _level = Math.max(1, _arg_1);
        }

        public function get badgeId():String
        {
            return (_base + _level);
        }


    }
}
