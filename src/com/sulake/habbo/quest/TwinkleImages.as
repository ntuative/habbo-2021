package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;

    public class TwinkleImages implements IDisposable 
    {

        private static const IMAGE_COUNT:int = 6;

        private var _questEngine:HabboQuestEngine;

        public function TwinkleImages(_arg_1:HabboQuestEngine)
        {
            var _local_2:int;
            super();
            _questEngine = _arg_1;
            _local_2 = 1;
            while (_local_2 <= 6)
            {
                _questEngine.windowManager.resourceManager.retrieveAsset(getImageUri(_local_2), null);
                _local_2++;
            };
        }

        private static function getImageUri(_arg_1:int):String
        {
            return (("${image.library.questing.url}ach_twinkle" + _arg_1) + ".png");
        }


        public function getImage(_arg_1:int):BitmapData
        {
            var _local_2:IAsset;
            if (_questEngine != null)
            {
                _local_2 = Component(_questEngine.windowManager).assets.getAssetByName(_questEngine.interpolate(getImageUri(_arg_1)));
                if (((!(_local_2 == null)) && (_local_2 is BitmapDataAsset)))
                {
                    return (_local_2.content as BitmapData);
                };
            };
            return (null);
        }

        public function dispose():void
        {
            _questEngine = null;
        }

        public function get disposed():Boolean
        {
            return (!(_questEngine == null));
        }


    }
}