package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;

    public class Animation implements IDisposable 
    {

        private var _SafeStr_1267:IBitmapWrapperWindow;
        private var _SafeStr_3120:int;
        private var _SafeStr_3121:Boolean;
        private var _SafeStr_1387:Array = [];

        public function Animation(_arg_1:IBitmapWrapperWindow)
        {
            _SafeStr_1267 = _arg_1;
            _SafeStr_1267.visible = false;
            if (_arg_1.bitmap == null)
            {
                _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            };
        }

        public function dispose():void
        {
            _SafeStr_1267 = null;
            if (_SafeStr_1387)
            {
                for each (var _local_1:AnimationObject in _SafeStr_1387)
                {
                    _local_1.dispose();
                };
                _SafeStr_1387 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1267 == null);
        }

        public function addObject(_arg_1:AnimationObject):void
        {
            _SafeStr_1387.push(_arg_1);
        }

        public function stop():void
        {
            _SafeStr_3121 = false;
            _SafeStr_1267.visible = false;
        }

        public function restart():void
        {
            _SafeStr_3120 = 0;
            _SafeStr_3121 = true;
            for each (var _local_1:AnimationObject in _SafeStr_1387)
            {
                _local_1.onAnimationStart();
            };
            draw();
            _SafeStr_1267.visible = true;
        }

        public function update(_arg_1:uint):void
        {
            if (_SafeStr_3121)
            {
                _SafeStr_3120 = (_SafeStr_3120 + _arg_1);
                draw();
            };
        }

        private function draw():void
        {
            var _local_1:Boolean;
            var _local_3:BitmapData;
            _SafeStr_1267.bitmap.fillRect(_SafeStr_1267.bitmap.rect, 0);
            if (_SafeStr_3121)
            {
                _local_1 = false;
                for each (var _local_2:AnimationObject in _SafeStr_1387)
                {
                    if (!_local_2.isFinished(_SafeStr_3120))
                    {
                        _local_1 = true;
                        _local_3 = _local_2.getBitmap(_SafeStr_3120);
                        if (_local_3 != null)
                        {
                            _SafeStr_1267.bitmap.copyPixels(_local_3, _local_3.rect, _local_2.getPosition(_SafeStr_3120));
                        };
                    };
                };
            };
            _SafeStr_1267.invalidate();
            _SafeStr_3121 = _local_1;
        }


    }
}

