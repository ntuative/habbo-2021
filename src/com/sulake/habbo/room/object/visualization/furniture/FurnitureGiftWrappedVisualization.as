package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObject;

    public class FurnitureGiftWrappedVisualization extends FurnitureVisualization 
    {

        private var _SafeStr_3311:int = 0;
        private var _SafeStr_3312:int = 0;


        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            updateTypes();
            super.update(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        private function updateTypes():void
        {
            var _local_5:IRoomObjectModel;
            var _local_1:int;
            var _local_3:String;
            var _local_4:int;
            var _local_2:IRoomObject = object;
            if (_local_2 != null)
            {
                _local_5 = _local_2.getModel();
                if (_local_5 != null)
                {
                    _local_1 = 1000;
                    _local_3 = _local_5.getString("furniture_extras");
                    _local_4 = parseInt(_local_3);
                    _SafeStr_3311 = Math.floor((_local_4 / _local_1));
                    _SafeStr_3312 = (_local_4 % _local_1);
                };
            };
        }

        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            if (_arg_2 <= 1)
            {
                return (_SafeStr_3311);
            };
            return (_SafeStr_3312);
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


    }
}

