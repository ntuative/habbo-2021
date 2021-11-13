package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.utils.Dictionary;
    import com.sulake.room.object.IRoomObjectModel;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.data.DirectionalOffsetData;

    public class FurnitureRoomBackgroundVisualization extends FurnitureRoomBrandingVisualization 
    {

        private var _SafeStr_3359:Dictionary;


        override public function dispose():void
        {
            super.dispose();
            _SafeStr_3359 = null;
        }

        override protected function getAdClickUrl(_arg_1:IRoomObjectModel):String
        {
            return (null);
        }

        override protected function imageReady(_arg_1:BitmapData, _arg_2:String):void
        {
            var _local_4:int;
            var _local_3:int;
            var _local_5:int;
            super.imageReady(_arg_1, _arg_2);
            if (_arg_1 != null)
            {
                _SafeStr_3359 = new Dictionary();
                _local_4 = 64;
                _local_3 = _arg_1.width;
                _local_5 = _arg_1.height;
                addDirectionalOffsets(_local_4, _local_5, _local_3);
                _local_4 = 32;
                _local_3 = int((_local_3 / 2));
                _local_5 = int((_local_5 / 2));
                addDirectionalOffsets(_local_4, _local_5, _local_3);
            };
        }

        private function addDirectionalOffsets(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_5:int = getSize(_arg_1);
            var _local_4:DirectionalOffsetData = new DirectionalOffsetData();
            _local_4.setOffset(1, 0, -(_arg_2));
            _local_4.setOffset(3, 0, 0);
            _local_4.setOffset(5, -(_arg_3), 0);
            _local_4.setOffset(7, -(_arg_3), -(_arg_2));
            _local_4.setOffset(4, (-(_arg_3) / 2), (-(_arg_2) / 2));
            _SafeStr_3359[_local_5] = _local_4;
        }

        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_5:int;
            var _local_4:DirectionalOffsetData;
            if (_SafeStr_3359 != null)
            {
                _local_5 = getSize(_arg_1);
                _local_4 = _SafeStr_3359[_local_5];
                if (_local_4 != null)
                {
                    return (_local_4.getOffsetX(_arg_2, 0) + getScaledOffset(_SafeStr_3360, _arg_1));
                };
            };
            return (super.getSpriteXOffset(_arg_1, _arg_2, _arg_3) + getScaledOffset(_SafeStr_3360, _arg_1));
        }

        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_5:int;
            var _local_4:DirectionalOffsetData;
            if (_SafeStr_3359 != null)
            {
                _local_5 = getSize(_arg_1);
                _local_4 = _SafeStr_3359[_local_5];
                if (_local_4 != null)
                {
                    return (_local_4.getOffsetY(_arg_2, 0) + getScaledOffset(_SafeStr_3361, _arg_1));
                };
            };
            return (super.getSpriteYOffset(_arg_1, _arg_2, _arg_3) + getScaledOffset(_SafeStr_3361, _arg_1));
        }

        override protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            return (super.getSpriteZOffset(_arg_1, _arg_2, _arg_3) + (_SafeStr_3362 * -1));
        }

        override protected function getSpriteMouseCapture(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            var _local_4:Boolean;
            return (_local_4);
        }

        private function getScaledOffset(_arg_1:int, _arg_2:int):Number
        {
            return ((_arg_1 * _arg_2) / 64);
        }


    }
}

