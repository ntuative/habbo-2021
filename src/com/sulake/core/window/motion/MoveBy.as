package com.sulake.core.window.motion
{
    import com.sulake.core.window.IWindow;

    use namespace friend;

    public class MoveBy extends MoveTo 
    {

        public function MoveBy(_arg_1:IWindow, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        override friend function start():void
        {
            _SafeStr_1152 = (target.x + _SafeStr_1152);
            _SafeStr_1153 = (target.y + _SafeStr_1153);
            super.friend::start();
        }


    }
}

