package com.sulake.core.window.utils
{
    import com.sulake.core.window.IWindow;

    public class WindowRectLimits implements IRectLimiter 
    {

        private var _minWidth:int = -2147483648;
        private var _maxWidth:int = 2147483647;
        private var _minHeight:int = -2147483648;
        private var _maxHeight:int = 2147483647;
        private var _SafeStr_1138:IWindow;

        public function WindowRectLimits(_arg_1:IWindow)
        {
            _SafeStr_1138 = _arg_1;
        }

        public function get minWidth():int
        {
            return (_minWidth);
        }

        public function get maxWidth():int
        {
            return (_maxWidth);
        }

        public function get minHeight():int
        {
            return (_minHeight);
        }

        public function get maxHeight():int
        {
            return (_maxHeight);
        }

        public function set minWidth(_arg_1:int):void
        {
            _minWidth = _arg_1;
            if ((((_minWidth > -2147483648) && (!(_SafeStr_1138.disposed))) && (_SafeStr_1138.width < _minWidth)))
            {
                _SafeStr_1138.width = _minWidth;
            };
        }

        public function set maxWidth(_arg_1:int):void
        {
            _maxWidth = _arg_1;
            if ((((_maxWidth < 2147483647) && (!(_SafeStr_1138.disposed))) && (_SafeStr_1138.width > _maxWidth)))
            {
                _SafeStr_1138.width = _maxWidth;
            };
        }

        public function set minHeight(_arg_1:int):void
        {
            _minHeight = _arg_1;
            if ((((_minHeight > -2147483648) && (!(_SafeStr_1138.disposed))) && (_SafeStr_1138.height < _minHeight)))
            {
                _SafeStr_1138.height = _minHeight;
            };
        }

        public function set maxHeight(_arg_1:int):void
        {
            _maxHeight = _arg_1;
            if ((((_maxHeight < 2147483647) && (!(_SafeStr_1138.disposed))) && (_SafeStr_1138.height > _maxHeight)))
            {
                _SafeStr_1138.height = _maxHeight;
            };
        }

        public function get isEmpty():Boolean
        {
            return ((((_minWidth == -2147483648) && (_maxWidth == 2147483647)) && (_minHeight == -2147483648)) && (_maxHeight == 2147483647));
        }

        public function setEmpty():void
        {
            _minWidth = -2147483648;
            _maxWidth = 2147483647;
            _minHeight = -2147483648;
            _maxHeight = 2147483647;
        }

        public function limit():void
        {
            if (((!(isEmpty)) && (_SafeStr_1138)))
            {
                if (_SafeStr_1138.width < _minWidth)
                {
                    _SafeStr_1138.width = _minWidth;
                }
                else
                {
                    if (_SafeStr_1138.width > _maxWidth)
                    {
                        _SafeStr_1138.width = _maxWidth;
                    };
                };
                if (_SafeStr_1138.height < _minHeight)
                {
                    _SafeStr_1138.height = _minHeight;
                }
                else
                {
                    if (_SafeStr_1138.height > _maxHeight)
                    {
                        _SafeStr_1138.height = _maxHeight;
                    };
                };
            };
        }

        public function assign(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            _minWidth = _arg_1;
            _maxWidth = _arg_2;
            _minHeight = _arg_3;
            _maxHeight = _arg_4;
            limit();
        }

        public function clone(_arg_1:IWindow):WindowRectLimits
        {
            var _local_2:WindowRectLimits = new WindowRectLimits(_arg_1);
            _local_2._minWidth = _minWidth;
            _local_2._maxWidth = _maxWidth;
            _local_2._minHeight = _minHeight;
            _local_2._maxHeight = _maxHeight;
            return (_local_2);
        }


    }
}

