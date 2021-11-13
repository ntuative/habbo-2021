package com.sulake.core.window.motion
{
    import com.sulake.core.window.IWindow;

    use namespace friend;

    public class MoveTo extends Interval 
    {

        protected var _SafeStr_1143:Number;
        protected var _SafeStr_1144:Number;
        protected var _SafeStr_1152:Number;
        protected var _SafeStr_1153:Number;
        protected var _SafeStr_1145:Number;
        protected var _SafeStr_1146:Number;

        public function MoveTo(_arg_1:IWindow, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            super(_arg_1, _arg_2);
            _SafeStr_1152 = _arg_3;
            _SafeStr_1153 = _arg_4;
        }

        override friend function start():void
        {
            super.friend::start();
            _SafeStr_1143 = target.x;
            _SafeStr_1144 = target.y;
            _SafeStr_1145 = (_SafeStr_1152 - _SafeStr_1143);
            _SafeStr_1146 = (_SafeStr_1153 - _SafeStr_1144);
        }

        override friend function update(_arg_1:Number):void
        {
            target.x = (_SafeStr_1143 + (_SafeStr_1145 * _arg_1));
            target.y = (_SafeStr_1144 + (_SafeStr_1146 * _arg_1));
        }


    }
}

