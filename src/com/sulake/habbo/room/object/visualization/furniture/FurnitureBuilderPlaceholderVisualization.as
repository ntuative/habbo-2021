package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.IRoomObjectModel;

    public class FurnitureBuilderPlaceholderVisualization extends FurnitureVisualization 
    {

        private var _SafeStr_3191:int = -1;
        private var _SafeStr_3192:int = -1;


        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_4:Boolean = super.updateModel(_arg_1);
            var _local_3:IRoomObjectModel = object.getModel();
            var _local_2:int = _local_3.getNumber("furniture_size_x");
            var _local_5:int = _local_3.getNumber("furniture_size_y");
            if (((!(_local_2 == _SafeStr_3191)) || (!(_local_5 == _SafeStr_3192))))
            {
                _SafeStr_3191 = _local_2;
                _SafeStr_3192 = _local_5;
                instantiateSprites(_arg_1);
            };
            return (_local_4);
        }

        private function instantiateSprites(_arg_1:Number):void
        {
            updateLayerCount(data.getLayerCount(_arg_1));
            createSprites(((data.getLayerCount(_arg_1) * _SafeStr_3191) * _SafeStr_3192));
            updateSprites(_arg_1, true, 0);
        }

        override protected function updateLayerCount(_arg_1:int):void
        {
            _SafeStr_3288 = _arg_1;
            if ((_SafeStr_3191 * _SafeStr_3192) > 1)
            {
                _SafeStr_3288 = (_SafeStr_3288 * (_SafeStr_3191 * _SafeStr_3192));
            };
        }

        override protected function getAdditionalSpriteCount():int
        {
            return (0);
        }

        override protected function getSpriteTag(_arg_1:int, _arg_2:int, _arg_3:int):String
        {
            return (super.getSpriteTag(_arg_1, _arg_2, getIndex(_arg_1, _arg_3)));
        }

        override protected function getSpriteAlpha(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (super.getSpriteAlpha(_arg_1, _arg_2, getIndex(_arg_1, _arg_3)));
        }

        override protected function getSpriteColor(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (super.getSpriteColor(_arg_1, getIndex(_arg_1, _arg_2), _arg_3));
        }

        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            return (super.getSpriteAssetName(_arg_1, getIndex(_arg_1, _arg_2)));
        }

        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_5:int = super.getSpriteXOffset(_arg_1, _arg_2, getIndex(_arg_1, _arg_3));
            var _local_4:int = int((_arg_3 / data.getLayerCount(_arg_1)));
            var _local_6:int = (_local_4 % _SafeStr_3192);
            var _local_7:int = int((_local_4 / _SafeStr_3192));
            return (_local_5 + (((_local_6 - _local_7) * _arg_1) / 2));
        }

        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_5:int = super.getSpriteYOffset(_arg_1, _arg_2, getIndex(_arg_1, _arg_3));
            var _local_4:int = int((_arg_3 / data.getLayerCount(_arg_1)));
            var _local_6:int = (_local_4 % _SafeStr_3192);
            var _local_7:int = int((_local_4 / _SafeStr_3192));
            return (_local_5 + (((_local_6 + _local_7) * _arg_1) / 4));
        }

        override protected function getSpriteMouseCapture(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            return (super.getSpriteMouseCapture(_arg_1, _arg_2, getIndex(_arg_1, _arg_3)));
        }

        override protected function getSpriteInk(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (super.getSpriteInk(_arg_1, _arg_2, getIndex(_arg_1, _arg_3)));
        }

        override protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            return (super.getSpriteZOffset(_arg_1, _arg_2, getIndex(_arg_1, _arg_3)));
        }

        private function getIndex(_arg_1:int, _arg_2:int):int
        {
            return ((data != null) ? (_arg_2 % data.getLayerCount(_arg_1)) : _arg_2);
        }


    }
}

