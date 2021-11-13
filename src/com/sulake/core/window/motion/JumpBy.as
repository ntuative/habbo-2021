package com.sulake.core.window.motion
{
    import com.sulake.core.window.IWindow;

    use namespace friend;

    public class JumpBy extends Interval 
    {

        protected var _SafeStr_1143:int;
        protected var _SafeStr_1144:int;
        protected var _SafeStr_1145:Number;
        protected var _SafeStr_1146:Number;
        protected var _SafeStr_1113:Number;
        protected var _SafeStr_1147:int;

        public function JumpBy(_arg_1:IWindow, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int)
        {
            super(_arg_1, _arg_2);
            _SafeStr_1145 = _arg_3;
            _SafeStr_1146 = _arg_4;
            _SafeStr_1113 = -(_arg_5);
            _SafeStr_1147 = _arg_6;
        }

        override friend function start():void
        {
            super.friend::start();
            _SafeStr_1143 = target.x;
            _SafeStr_1144 = target.y;
        }

        override friend function update(_arg_1:Number):void
        {
            super.friend::update(_arg_1);
            target.x = (_SafeStr_1143 + (_SafeStr_1145 * _arg_1));
            target.y = ((_SafeStr_1144 + (_SafeStr_1113 * Math.abs(Math.sin(((_arg_1 * 3.14159265358979) * _SafeStr_1147))))) + (_SafeStr_1146 * _arg_1));
        }


    }
}

