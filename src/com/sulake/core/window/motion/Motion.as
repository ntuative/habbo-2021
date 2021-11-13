package com.sulake.core.window.motion
{
    import com.sulake.core.window.IWindow;

    use namespace friend;

    public class Motion 
    {

        protected var _SafeStr_1138:IWindow;
        protected var _SafeStr_801:Boolean;
        protected var _SafeStr_1139:Boolean = true;
        protected var _SafeStr_1148:String;

        public function Motion(_arg_1:IWindow)
        {
            _SafeStr_1138 = _arg_1;
        }

        public function get running():Boolean
        {
            return (((_SafeStr_801) && (_SafeStr_1138)) && (!(_SafeStr_1138.disposed)));
        }

        public function get complete():Boolean
        {
            return (_SafeStr_1139);
        }

        public function set target(_arg_1:IWindow):void
        {
            _SafeStr_1138 = _arg_1;
        }

        public function get target():IWindow
        {
            return (_SafeStr_1138);
        }

        public function set tag(_arg_1:String):void
        {
            _SafeStr_1148 = _arg_1;
        }

        public function get tag():String
        {
            return (_SafeStr_1148);
        }

        friend function start():void
        {
            _SafeStr_801 = true;
        }

        friend function update(_arg_1:Number):void
        {
        }

        friend function stop():void
        {
            _SafeStr_1138 = null;
            _SafeStr_801 = false;
        }

        friend function tick(_arg_1:int):void
        {
        }


    }
}

