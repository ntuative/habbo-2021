package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Rectangle;
    import flash.geom.ColorTransform;
    import flash.geom.Point;

    public class WindowModel implements IDisposable 
    {

        protected var _offsetX:int;
        protected var _offsetY:int;
        protected var _SafeStr_954:int;
        protected var _SafeStr_955:int;
        protected var _SafeStr_908:int;
        protected var _SafeStr_909:int;
        protected var _SafeStr_1225:Rectangle;
        protected var _SafeStr_1227:Rectangle;
        protected var _SafeStr_1240:Rectangle;
        protected var _SafeStr_1241:Rectangle;
        protected var _context:WindowContext;
        protected var _background:Boolean = false;
        protected var _fillColor:uint = 0xFFFFFF;
        protected var _SafeStr_1231:ColorTransform;
        protected var _alphaColor:uint;
        protected var _SafeStr_1239:uint = 10;
        protected var _SafeStr_1232:Boolean = true;
        protected var _SafeStr_898:Boolean = true;
        protected var _SafeStr_1230:Number = 1;
        protected var _SafeStr_1226:uint;
        protected var _SafeStr_448:uint;
        protected var _style:uint;
        protected var _SafeStr_741:uint;
        protected var _caption:String = "";
        protected var _name:String;
        protected var _SafeStr_698:uint;
        protected var _SafeStr_745:Array;
        protected var _disposed:Boolean = false;
        protected var _SafeStr_1238:String = "";

        public function WindowModel(_arg_1:uint, _arg_2:String, _arg_3:uint, _arg_4:uint, _arg_5:uint, _arg_6:WindowContext, _arg_7:Rectangle, _arg_8:Array=null, _arg_9:String="")
        {
            _SafeStr_698 = _arg_1;
            _name = _arg_2;
            _SafeStr_741 = _arg_3;
            _SafeStr_1226 = _arg_5;
            _SafeStr_448 = 0;
            _style = _arg_4;
            _SafeStr_745 = _arg_8;
            _context = _arg_6;
            _SafeStr_1238 = _arg_9;
            _SafeStr_954 = _arg_7.x;
            _SafeStr_955 = _arg_7.y;
            _SafeStr_908 = _arg_7.width;
            _SafeStr_909 = _arg_7.height;
            _SafeStr_1225 = _arg_7.clone();
            _SafeStr_1227 = _arg_7.clone();
        }

        public function get x():int
        {
            return (_SafeStr_954);
        }

        public function get y():int
        {
            return (_SafeStr_955);
        }

        public function get width():int
        {
            return (_SafeStr_908);
        }

        public function get height():int
        {
            return (_SafeStr_909);
        }

        public function get position():Point
        {
            return (new Point(_SafeStr_954, _SafeStr_955));
        }

        public function get rectangle():Rectangle
        {
            return (new Rectangle(_SafeStr_954, _SafeStr_955, _SafeStr_908, _SafeStr_909));
        }

        public function get context():IWindowContext
        {
            return (_context);
        }

        public function get mouseThreshold():uint
        {
            return (_SafeStr_1239);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get background():Boolean
        {
            return (_background);
        }

        public function get clipping():Boolean
        {
            return (_SafeStr_1232);
        }

        public function get visible():Boolean
        {
            return (_SafeStr_898);
        }

        public function get color():uint
        {
            return (_fillColor);
        }

        public function get alpha():uint
        {
            return (_alphaColor >>> 24);
        }

        public function get blend():Number
        {
            return (_SafeStr_1230);
        }

        public function get param():uint
        {
            return (_SafeStr_1226);
        }

        public function get state():uint
        {
            return (_SafeStr_448);
        }

        public function get style():uint
        {
            return (_style);
        }

        public function get type():uint
        {
            return (_SafeStr_741);
        }

        public function get caption():String
        {
            return (_caption);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get id():int
        {
            return (_SafeStr_698);
        }

        public function get tags():Array
        {
            return ((_SafeStr_745) ? _SafeStr_745 : _SafeStr_745 = []);
        }

        public function get left():int
        {
            return (_SafeStr_954);
        }

        public function get top():int
        {
            return (_SafeStr_955);
        }

        public function get right():int
        {
            return (_SafeStr_954 + _SafeStr_908);
        }

        public function get bottom():int
        {
            return (_SafeStr_955 + _SafeStr_909);
        }

        public function get renderingX():int
        {
            return (_offsetX + _SafeStr_954);
        }

        public function get renderingY():int
        {
            return (_offsetY + _SafeStr_955);
        }

        public function get renderingWidth():int
        {
            return (_SafeStr_908 + Math.abs(etchingPoint.x));
        }

        public function get renderingHeight():int
        {
            return (_SafeStr_909 + Math.abs(etchingPoint.y));
        }

        public function get renderingRectangle():Rectangle
        {
            return (new Rectangle(renderingX, renderingY, renderingWidth, renderingHeight));
        }

        public function get etchingPoint():Point
        {
            return (new Point(0, 0));
        }

        public function get dynamicStyle():String
        {
            return (_SafeStr_1238);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _disposed = true;
                _context = null;
                _SafeStr_448 = 0x40000000;
                _SafeStr_745 = null;
                _SafeStr_954 = (_SafeStr_955 = (_SafeStr_908 = (_SafeStr_909 = 0)));
            };
        }

        public function invalidate(_arg_1:Rectangle=null):void
        {
        }

        public function getInitialWidth():int
        {
            return (_SafeStr_1225.width);
        }

        public function getInitialHeight():int
        {
            return (_SafeStr_1225.height);
        }

        public function getPreviousWidth():int
        {
            return (_SafeStr_1227.width);
        }

        public function getPreviousHeight():int
        {
            return (_SafeStr_1227.height);
        }

        public function getMinimizedWidth():int
        {
            return ((_SafeStr_1240) ? _SafeStr_1240.width : 0);
        }

        public function getMinimizedHeight():int
        {
            return ((_SafeStr_1240) ? _SafeStr_1240.height : 0);
        }

        public function getMaximizedWidth():int
        {
            return ((_SafeStr_1241) ? _SafeStr_1241.width : 2147483647);
        }

        public function getMaximizedHeight():int
        {
            return ((_SafeStr_1241) ? _SafeStr_1241.height : 2147483647);
        }

        public function testTypeFlag(_arg_1:uint, _arg_2:uint=0):Boolean
        {
            if (_arg_2 > 0)
            {
                return (((_SafeStr_741 & _arg_2) ^ _arg_1) == 0);
            };
            return ((_SafeStr_741 & _arg_1) == _arg_1);
        }

        public function testStateFlag(_arg_1:uint, _arg_2:uint=0):Boolean
        {
            if (_arg_2 > 0)
            {
                return (((_SafeStr_448 & _arg_2) ^ _arg_1) == 0);
            };
            return ((_SafeStr_448 & _arg_1) == _arg_1);
        }

        public function testStyleFlag(_arg_1:uint, _arg_2:uint=0):Boolean
        {
            if (_arg_2 > 0)
            {
                return (((_style & _arg_2) ^ _arg_1) == 0);
            };
            return ((_style & _arg_1) == _arg_1);
        }

        public function testParamFlag(_arg_1:uint, _arg_2:uint=0):Boolean
        {
            if (_arg_2 > 0)
            {
                return (((_SafeStr_1226 & _arg_2) ^ _arg_1) == 0);
            };
            return ((_SafeStr_1226 & _arg_1) == _arg_1);
        }


    }
}

