package com.sulake.habbo.roomevents
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;

    public class Util 
    {


        public static function setProcDirectly(_arg_1:IWindow, _arg_2:Function):void
        {
            _arg_1.setParamFlag(1, true);
            _arg_1.procedure = _arg_2;
        }

        public static function getLowestPoint(_arg_1:IWindowContainer):int
        {
            var _local_2:int;
            var _local_4:IWindow;
            var _local_3:int;
            _local_2 = 0;
            while (_local_2 < _arg_1.numChildren)
            {
                _local_4 = _arg_1.getChildAt(_local_2);
                if (_local_4.visible)
                {
                    _local_3 = Math.max(_local_3, (_local_4.y + _local_4.height));
                };
                _local_2++;
            };
            return (_local_3);
        }

        public static function hideChildren(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _arg_1.numChildren)
            {
                _arg_1.getChildAt(_local_2).visible = false;
                _local_2++;
            };
        }

        public static function showChildren(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _arg_1.numChildren)
            {
                _arg_1.getChildAt(_local_2).visible = true;
                _local_2++;
            };
        }

        public static function moveChildrenToColumn(_arg_1:IWindowContainer, _arg_2:Array, _arg_3:int, _arg_4:int):void
        {
            var _local_6:IWindow;
            for each (var _local_5:String in _arg_2)
            {
                _local_6 = _arg_1.getChildByName(_local_5);
                if ((((!(_local_6 == null)) && (_local_6.visible)) && (_local_6.height > 0)))
                {
                    _local_6.y = _arg_3;
                    _arg_3 = (_arg_3 + (_local_6.height + _arg_4));
                };
            };
        }

        public static function moveAllChildrenToColumn(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:IWindow;
            while (_local_4 < _arg_1.numChildren)
            {
                _local_5 = _arg_1.getChildAt(_local_4);
                if ((((!(_local_5 == null)) && (_local_5.visible)) && (_local_5.height > 0)))
                {
                    _local_5.y = _arg_2;
                    _arg_2 = (_arg_2 + (_local_5.height + _arg_3));
                };
                _local_4++;
            };
        }


    }
}