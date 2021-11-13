package com.sulake.habbo.game.snowwar.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.utils.Timer;
    import flash.display.BitmapData;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.TimerEvent;
    import flash.geom.Point;

    public class SnowWarAnimatedWindowElement implements IDisposable 
    {

        private var _SafeStr_2294:int;
        private var _SafeStr_2573:String;
        private var _SafeStr_748:Array = [];
        private var _currentFrame:int;
        private var _SafeStr_2574:IBitmapWrapperWindow;
        private var _SafeStr_1163:Timer;
        private var _disposed:Boolean = false;

        public function SnowWarAnimatedWindowElement(_arg_1:IAssetLibrary, _arg_2:IBitmapWrapperWindow, _arg_3:String, _arg_4:int, _arg_5:int=100, _arg_6:Boolean=false)
        {
            var _local_7:int;
            super();
            _SafeStr_2574 = _arg_2;
            _SafeStr_2573 = _arg_3;
            _SafeStr_2294 = _arg_4;
            _local_7 = 1;
            while (_local_7 <= _SafeStr_2294)
            {
                if (_arg_1.hasAsset((_SafeStr_2573 + _local_7)))
                {
                    _SafeStr_748.push((_arg_1.getAssetByName((_SafeStr_2573 + _local_7)).content as BitmapData));
                }
                else
                {
                    _SafeStr_748.push(new BitmapData(1, 1));
                    Logger.log((("Missing asset for Snow War: " + _SafeStr_2573) + _local_7));
                };
                _local_7++;
            };
            if (_arg_6)
            {
                _SafeStr_2294 = (_SafeStr_2294 + (_arg_4 - 2));
                _local_7 = (_arg_4 - 1);
                while (_local_7 > 1)
                {
                    if (_arg_1.hasAsset((_SafeStr_2573 + _local_7)))
                    {
                        _SafeStr_748.push((_arg_1.getAssetByName((_SafeStr_2573 + _local_7)).content as BitmapData));
                    }
                    else
                    {
                        _SafeStr_748.push(new BitmapData(1, 1));
                        Logger.log((("Missing loop asset for Snow War: " + _SafeStr_2573) + _local_7));
                    };
                    _local_7--;
                };
            };
            update();
            _SafeStr_1163 = new Timer(_arg_5);
            _SafeStr_1163.addEventListener("timer", onTimer);
            _SafeStr_1163.start();
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_1163.removeEventListener("timer", onTimer);
                _SafeStr_1163.stop();
                _SafeStr_1163 = null;
                if (((_SafeStr_2574) && (_SafeStr_2574.bitmap)))
                {
                    _SafeStr_2574.bitmap.fillRect(_SafeStr_2574.bitmap.rect, 0);
                    _SafeStr_2574.invalidate();
                };
                _SafeStr_2574 = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function onTimer(_arg_1:TimerEvent):void
        {
            update();
        }

        private function update():void
        {
            _currentFrame = (++_currentFrame % _SafeStr_2294);
            if (!_SafeStr_2574.bitmap)
            {
                _SafeStr_2574.bitmap = new BitmapData(_SafeStr_2574.width, _SafeStr_2574.height);
            };
            _SafeStr_2574.bitmap.fillRect(_SafeStr_2574.bitmap.rect, 0);
            var _local_2:BitmapData = _SafeStr_748[_currentFrame];
            var _local_1:Point = new Point(((_SafeStr_2574.width - _local_2.width) / 2), ((_SafeStr_2574.height - _local_2.height) / 2));
            _SafeStr_2574.bitmap.copyPixels(_local_2, _local_2.rect, _local_1);
            _SafeStr_2574.invalidate();
        }


    }
}

