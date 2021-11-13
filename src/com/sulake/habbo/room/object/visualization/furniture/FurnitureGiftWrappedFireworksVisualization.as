package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObject;

    public class FurnitureGiftWrappedFireworksVisualization extends FurnitureFireworksVisualization 
    {

        private static const PRESENT_DEFAULT_STATE:int = 0;
        private static const MAX_PACKET_TYPE_VALUE:int = 9;
        private static const MAX_RIBBON_TYPE_VALUE:int = 11;

        private var _SafeStr_3311:int = 0;
        private var _SafeStr_3312:int = 0;
        private var _SafeStr_448:int = 0;


        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            updateTypes();
            super.update(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        private function updateTypes():void
        {
            var _local_6:IRoomObjectModel;
            var _local_1:int;
            var _local_4:String;
            var _local_5:int;
            var _local_2:int;
            var _local_7:int;
            var _local_3:IRoomObject = object;
            if (_local_3 != null)
            {
                _local_6 = _local_3.getModel();
                if (_local_6 != null)
                {
                    _local_1 = 1000;
                    _local_4 = _local_6.getString("furniture_extras");
                    _local_5 = parseInt(_local_4);
                    _local_2 = int(Math.floor((_local_5 / _local_1)));
                    _local_7 = (_local_5 % _local_1);
                    _SafeStr_3311 = ((_local_2 > 9) ? 0 : _local_2);
                    _SafeStr_3312 = ((_local_7 > 11) ? 0 : _local_7);
                };
            };
        }

        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            if (_SafeStr_448 == 0)
            {
                if (_arg_2 <= 1)
                {
                    return (_SafeStr_3311);
                };
                if (_arg_2 == 2)
                {
                    return (_SafeStr_3312);
                };
            };
            return (super.getFrameNumber(_arg_1, _arg_2));
        }

        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_3:int = getSize(_arg_1);
            var _local_4:String = type;
            var _local_5:String = "";
            if (_arg_2 < (spriteCount - 1))
            {
                _local_5 = String.fromCharCode(("a".charCodeAt() + _arg_2));
            }
            else
            {
                _local_5 = "sd";
            };
            var _local_6:int = getFrameNumber(_arg_1, _arg_2);
            _local_4 = (_local_4 + ((((("_" + _local_3) + "_") + _local_5) + "_") + direction));
            _local_4 = (_local_4 + ("_" + _local_6));
            return (_local_4);
        }

        override protected function setAnimation(_arg_1:int):void
        {
            _SafeStr_448 = _arg_1;
            super.setAnimation(_arg_1);
        }


    }
}

