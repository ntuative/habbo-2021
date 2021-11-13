package login
{
    import flash.display.Sprite;
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.display.Bitmap;
    import flash.geom.Matrix;

    public class Background extends Sprite implements IDisposable 
    {

        private static const background_tiles_png:Class = HabboBackground_background_tiles_png;

        private var _backgroundImage:BitmapData;
        private var _disposed:Boolean;
        private var _SafeStr_4553:Sprite;

        public function Background()
        {
            addEventListener("addedToStage", onAddedToStage);
            addEventListener("removedFromStage", onRemovedFromStage);
        }

        public function dispose():void
        {
            _disposed = true;
            while (numChildren > 0)
            {
                removeChildAt(0);
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
        }

        protected function onAddedToStage(_arg_1:Event):void
        {
            _SafeStr_4553 = new Sprite();
            var _local_2:Bitmap = new background_tiles_png();
            _backgroundImage = _local_2.bitmapData;
            addChild(_SafeStr_4553);
            resize();
        }

        protected function stageChangeResize(_arg_1:Event):void
        {
            resize();
        }

        public function resize():void
        {
            var _local_2:String;
            var _local_5:Array;
            var _local_3:Array;
            var _local_4:Array;
            var _local_1:Matrix;
            var _local_6:String;
            if (stage)
            {
                _local_2 = "linear";
                _local_5 = [809599, 801381];
                _local_3 = [1, 1];
                _local_4 = [127, 0xFF];
                _local_1 = new Matrix();
                _local_1.createGradientBox(50, 100, 0, 0, 0);
                _local_1.rotate((3.14159265358979 / 2));
                _local_1.scale((stage.stageWidth / 50), (stage.stageHeight / 100));
                _local_6 = "pad";
                graphics.beginGradientFill(_local_2, _local_5, _local_3, _local_4, _local_1, _local_6);
                graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
                if (_SafeStr_4553 != null)
                {
                    _SafeStr_4553.graphics.clear();
                    _SafeStr_4553.graphics.beginBitmapFill(_backgroundImage);
                    _SafeStr_4553.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
                    _SafeStr_4553.graphics.endFill();
                };
            };
        }


    }
}

