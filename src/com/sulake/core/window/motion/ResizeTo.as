package com.sulake.core.window.motion
{
    import com.sulake.core.window.IWindow;

    use namespace friend;

    public class ResizeTo extends Interval 
    {

        protected var _SafeStr_1154:Number;
        protected var _SafeStr_1155:Number;
        protected var _SafeStr_1156:Number;
        protected var _SafeStr_1157:Number;
        protected var _SafeStr_1158:Number;
        protected var _SafeStr_1159:Number;

        public function ResizeTo(_arg_1:IWindow, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            super(_arg_1, _arg_2);
            _SafeStr_1156 = _arg_3;
            _SafeStr_1157 = _arg_4;
        }

        override friend function start():void
        {
            super.friend::start();
            _SafeStr_1154 = target.width;
            _SafeStr_1155 = target.height;
            _SafeStr_1158 = (_SafeStr_1156 - _SafeStr_1154);
            _SafeStr_1159 = (_SafeStr_1157 - _SafeStr_1155);
        }

        override friend function update(_arg_1:Number):void
        {
            target.width = (_SafeStr_1154 + (_SafeStr_1158 * _arg_1));
            target.height = (_SafeStr_1155 + (_SafeStr_1159 * _arg_1));
        }


    }
}

