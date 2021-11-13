package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import flash.events.TimerEvent;

    public class Icon implements IDisposable 
    {

        protected static const ALIGN_LEFT:int = 0;
        protected static const ALIGN_CENTER:int = 1;
        protected static const ALIGN_RIGHT:int = 2;
        protected static const MASK_HORIZONTAL:int = 3;
        protected static const ALIGN_TOP:int = 4;
        protected static const ALIGN_MIDDLE:int = 8;
        protected static const ALIGN_BOTTOM:int = 18;
        protected static const MASK_VERTICAL:int = 18;

        private var _disposed:Boolean = false;
        private var _disabled:Boolean = false;
        protected var _SafeStr_1384:BitmapDataAsset;
        protected var _SafeStr_1267:IBitmapWrapperWindow;
        private var _alignment:uint = 9;
        protected var _SafeStr_1163:Timer;
        protected var _frame:int = 0;
        private var _point:Point = new Point();
        protected var _SafeStr_2432:Boolean = false;
        protected var _hover:Boolean = false;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get disabled():Boolean
        {
            return (_disabled);
        }

        protected function set image(_arg_1:BitmapDataAsset):void
        {
            _SafeStr_1384 = _arg_1;
            redraw();
        }

        protected function get image():BitmapDataAsset
        {
            return (_SafeStr_1384);
        }

        protected function set canvas(_arg_1:IBitmapWrapperWindow):void
        {
            _SafeStr_1267 = _arg_1;
            redraw();
        }

        protected function get canvas():IBitmapWrapperWindow
        {
            return (_SafeStr_1267);
        }

        protected function set alignment(_arg_1:uint):void
        {
            _alignment = _arg_1;
            redraw();
        }

        protected function get alignment():uint
        {
            return (_alignment);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                toggleTimer(false, 0);
                image = null;
                canvas = null;
                _disposed = true;
            };
        }

        public function notify(_arg_1:Boolean):void
        {
            _SafeStr_2432 = _arg_1;
            if (((_SafeStr_2432) && (_disabled)))
            {
                enable(true);
            };
        }

        public function hover(_arg_1:Boolean):void
        {
            _hover = _arg_1;
        }

        public function enable(_arg_1:Boolean):void
        {
            _disabled = (!(_arg_1));
        }

        protected function redraw():void
        {
            var _local_1:BitmapData;
            if (((_SafeStr_1267) && (!(_SafeStr_1267.disposed))))
            {
                if (!_SafeStr_1267.bitmap)
                {
                    _SafeStr_1267.bitmap = new BitmapData(_SafeStr_1267.width, _SafeStr_1267.height, true, 0);
                }
                else
                {
                    _SafeStr_1267.bitmap.fillRect(_SafeStr_1267.bitmap.rect, 0);
                };
                if (((_SafeStr_1384) && (!(_SafeStr_1384.disposed))))
                {
                    var _local_2:Number = 0;
                    _point.y = _local_2;
                    _point.x = _local_2;
                    _local_1 = (_SafeStr_1384.content as BitmapData);
                    switch ((_alignment & 0x03))
                    {
                        case 1:
                            _point.x = ((_SafeStr_1267.bitmap.width / 2) - (_local_1.width / 2));
                            break;
                        case 2:
                            _point.x = (_SafeStr_1267.bitmap.width - _local_1.width);
                        default:
                    };
                    switch ((_alignment & 0x12))
                    {
                        case 8:
                            _point.y = ((_SafeStr_1267.bitmap.height / 2) - (_local_1.height / 2));
                            break;
                        case 18:
                            _point.y = (_SafeStr_1267.bitmap.height - _local_1.height);
                        default:
                    };
                    _SafeStr_1267.bitmap.copyPixels(_local_1, _local_1.rect, _point);
                    _SafeStr_1267.invalidate();
                };
            };
        }

        protected function toggleTimer(_arg_1:Boolean, _arg_2:int):void
        {
            if (_arg_1)
            {
                if (!_SafeStr_1163)
                {
                    _SafeStr_1163 = new Timer(_arg_2, 0);
                    _SafeStr_1163.addEventListener("timer", onTimerEvent);
                    _SafeStr_1163.start();
                    onTimerEvent(null);
                };
                _SafeStr_1163.delay = _arg_2;
            }
            else
            {
                _frame = 0;
                if (_SafeStr_1163)
                {
                    _SafeStr_1163.reset();
                    _SafeStr_1163.removeEventListener("timer", onTimerEvent);
                    _SafeStr_1163 = null;
                };
            };
        }

        protected function onTimerEvent(_arg_1:TimerEvent):void
        {
        }


    }
}

