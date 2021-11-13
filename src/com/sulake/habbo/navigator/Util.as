package com.sulake.habbo.navigator
{
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;

    public class Util 
    {

        private static var CUT_TO_WIDTH:CutToWidth = new CutToWidth();
        private static var CUT_TO_HEIGHT:CutToHeight = new CutToHeight();


        public static function remove(_arg_1:Array, _arg_2:Object):int
        {
            var _local_3:int = _arg_1.indexOf(_arg_2);
            if (_local_3 >= 0)
            {
                _arg_1.splice(_local_3, 1);
            };
            return (_local_3);
        }

        public static function getLocationRelativeTo(_arg_1:IWindow, _arg_2:int, _arg_3:int):Rectangle
        {
            if (_arg_1 == null)
            {
                return (new Rectangle(300, 200, _arg_2, _arg_3));
            };
            var _local_4:int = (_arg_1.width - _arg_2);
            var _local_5:int = (_arg_1.height - _arg_3);
            return (new Rectangle((_arg_1.x + (0.5 * _local_4)), (_arg_1.y + (0.5 * _local_5)), _arg_2, _arg_3));
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

        public static function hasVisibleChildren(_arg_1:IWindowContainer):Boolean
        {
            var _local_2:int;
            var _local_3:IWindow;
            _local_2 = 0;
            while (_local_2 < _arg_1.numChildren)
            {
                _local_3 = _arg_1.getChildAt(_local_2);
                if (_local_3.visible)
                {
                    return (true);
                };
                _local_2++;
            };
            return (false);
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

        public static function moveChildrenToRow(_arg_1:IWindowContainer, _arg_2:Array, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            var _local_7:IWindow;
            for each (var _local_6:String in _arg_2)
            {
                _local_7 = _arg_1.getChildByName(_local_6);
                if (((!(_local_7 == null)) && (_local_7.visible)))
                {
                    _local_7.x = _arg_3;
                    _local_7.y = _arg_4;
                    _arg_3 = (_arg_3 + (_local_7.width + _arg_5));
                };
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

        public static function layoutChildrenInArea(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int, _arg_4:int=0, _arg_5:int=0):void
        {
            var _local_8:int;
            var _local_9:IWindow;
            var _local_6:int = _arg_5;
            var _local_7:int;
            _local_8 = 0;
            while (_local_8 < _arg_1.numChildren)
            {
                _local_9 = _arg_1.getChildAt(_local_8);
                if (_local_9.visible)
                {
                    if (((_local_6 > 0) && ((_local_6 + _local_9.width) > _arg_2)))
                    {
                        _local_6 = 0;
                        _local_7 = (_local_7 + _arg_3);
                    };
                    _local_9.x = _local_6;
                    _local_9.y = _local_7;
                    _local_6 = (_local_6 + (_local_9.width + _arg_4));
                };
                _local_8++;
            };
        }

        public static function setProc(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Function):void
        {
            var _local_4:IWindow = _arg_1.findChildByName(_arg_2);
            _local_4.setParamFlag(1, true);
            _local_4.procedure = _arg_3;
        }

        public static function setProcDirectly(_arg_1:IWindow, _arg_2:Function):void
        {
            _arg_1.setParamFlag(1, true);
            _arg_1.procedure = _arg_2;
        }

        public static function trim(_arg_1:String):String
        {
            if (((_arg_1 == null) || (_arg_1.length < 1)))
            {
                return (_arg_1);
            };
            while (_arg_1.charAt(0) == " ")
            {
                _arg_1 = _arg_1.substring(1);
            };
            while (_arg_1.charAt((_arg_1.length - 1)) == " ")
            {
                _arg_1 = _arg_1.substring(0, (_arg_1.length - 1));
            };
            return (_arg_1);
        }

        public static function cutTextToWidth(_arg_1:ITextWindow, _arg_2:String, _arg_3:int):void
        {
            _arg_1.text = _arg_2;
            if (_arg_1.textWidth <= _arg_3)
            {
                return;
            };
            CUT_TO_WIDTH.beforeSearch(_arg_2, _arg_1, _arg_3);
            binarySearch(CUT_TO_WIDTH, (_arg_2.length - 1));
        }

        public static function binarySearch(_arg_1:BinarySearchTest, _arg_2:int):void
        {
            var _local_5:int;
            var _local_4:Boolean;
            var _local_3:int;
            var _local_6:int;
            while (true)
            {
                if (_local_3 >= _arg_2)
                {
                    _arg_1.test(_local_6);
                    return;
                };
                _local_5 = int((_local_3 + Math.floor(((_arg_2 - _local_3) / 2))));
                _local_4 = _arg_1.test(_local_5);
                if (_local_4)
                {
                    _arg_2 = (_local_5 - 1);
                }
                else
                {
                    _local_6 = Math.max(_local_6, _local_5);
                    _local_3 = (_local_5 + 1);
                };
            };
        }

        public static function containsMouse(_arg_1:IWindow):Boolean
        {
            var _local_2:Point = new Point();
            _arg_1.getRelativeMousePosition(_local_2);
            return ((((_local_2.x >= 0) && (_local_2.y >= 0)) && (_local_2.x < _arg_1.width)) && (_local_2.y < _arg_1.height));
        }


    }
}