package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;

    public class TextMargins implements IMargins, IDisposable 
    {

        private var _left:int;
        private var _right:int;
        private var _top:int;
        private var _bottom:int;
        private var _callback:Function;
        private var _disposed:Boolean = false;

        public function TextMargins(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function)
        {
            _left = _arg_1;
            _top = _arg_2;
            _right = _arg_3;
            _bottom = _arg_4;
            _callback = ((_arg_5 != null) ? _arg_5 : nullCallback);
        }

        public function get left():int
        {
            return (_left);
        }

        public function get right():int
        {
            return (_right);
        }

        public function get top():int
        {
            return (_top);
        }

        public function get bottom():int
        {
            return (_bottom);
        }

        public function set left(_arg_1:int):void
        {
            _left = _arg_1;
            _callback(this); //not popped
        }

        public function set right(_arg_1:int):void
        {
            _right = _arg_1;
            _callback(this); //not popped
        }

        public function set top(_arg_1:int):void
        {
            _top = _arg_1;
            _callback(this); //not popped
        }

        public function set bottom(_arg_1:int):void
        {
            _bottom = _arg_1;
            _callback(this); //not popped
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get isZeroes():Boolean
        {
            return ((((_left == 0) && (_right == 0)) && (_top == 0)) && (_bottom == 0));
        }

        public function assign(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function):void
        {
            _left = _arg_1;
            _top = _arg_2;
            _right = _arg_3;
            _bottom = _arg_4;
            _callback = ((_arg_5 != null) ? _arg_5 : nullCallback);
        }

        public function clone(_arg_1:Function):TextMargins
        {
            return (new TextMargins(_left, _top, _right, _bottom, _arg_1));
        }

        public function dispose():void
        {
            _callback = null;
            _disposed = true;
        }

        private function nullCallback(_arg_1:IMargins):void
        {
        }


    }
}