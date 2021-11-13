package com.sulake.habbo.catalog.purse
{
    import com.sulake.core.runtime.ICoreConfiguration;

    public class _SafeStr_139 
    {

        public static const DUCKET:int = 0;
        public static const _SafeStr_1496:int = 3;
        public static const _SafeStr_1497:int = 5;
        public static const SEASONAL_1:int = 101;
        public static const SEASONAL_2:int = 102;
        public static const SEASONAL_3:int = 103;
        public static const SEASONAL_4:int = 104;
        public static const SEASONAL_5:int = 105;
        public static const NO_OP_1:int = 1;
        public static const NO_OP_2:int = 2;
        public static const NO_OP_4:int = 4;


        public static function values():Array
        {
            return ([0, 101, 102, 103, 104, 105, 1, 2, 4]);
        }

        public static function getIconStyleFor(_arg_1:int, _arg_2:ICoreConfiguration, _arg_3:Boolean, _arg_4:Boolean=false):int
        {
            var _local_5:String;
            if (_arg_1 == -1)
            {
                return ((_arg_3) ? 34 : 35);
            };
            if (_arg_1 == 0)
            {
                return ((_arg_3) ? 32 : 33);
            };
            if (_arg_1 == 3)
            {
                return ((_arg_3) ? 36 : 37);
            };
            if (_arg_1 == 5)
            {
                if (_arg_2.getBoolean("diamonds.enabled"))
                {
                    return ((_arg_3) ? 41 : 42);
                };
                return ((_arg_3) ? 53 : 54);
            };
            _local_5 = (((("currencyiconstyle." + ((_arg_3) ? "big" : "small")) + ".") + _arg_1) + ((_arg_4) ? ".combo" : ""));
            return (_arg_2.getInteger(_local_5, 0));
        }

        public static function isVisible(_arg_1:int):Boolean
        {
            if ([1, 2, 4].indexOf(_arg_1) != 1)
            {
                return (false);
            };
            return (true);
        }


    }
}

